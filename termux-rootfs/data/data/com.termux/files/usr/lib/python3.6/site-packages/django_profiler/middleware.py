# Original version, and modifications:
# * udfalkso, https://djangosnippets.org/snippets/186/
# * Shwagroo Team, https://djangosnippets.org/snippets/605/
# * Gun.io, https://gun.io/blog/fast-as-fuck-django-part-1-using-a-profiler/
# * sfllaw, https://djangosnippets.org/snippets/2126/
# * Matthew Somerville, mySociety, this version
#
# Install by adding to your MIDDLEWARE_CLASSES (I'd say only when DEBUG is
# True, but I find I want to profile as close to production as possible, so
# that might not be what you want) and then add __prof__ to your URL.

import re
import cProfile
import StringIO
import cPickle
import pstats
from base64 import b64decode, b64encode
from django.http import HttpResponse
from django.middleware.csrf import get_token
from django.utils import html


class ProfilerMiddleware(object):
    def process_request(self, request):
        self.prof = None
        if '__prof__' in request.GET:
            if (request.REQUEST.get('__prof__stats', False)):
                stats = StatsView.unpickle(request.REQUEST['__prof__stats'])
                return stats.display(request)
            else:
                self.prof = cProfile.Profile()
                self.prof.enable()

    def process_response(self, request, response):
        if not self.prof:
            return response

        self.prof.disable()
        stats = StatsView(pstats.Stats(self.prof, stream=StringIO.StringIO()))
        return stats.display(request)


class StatsView(object):
    sort_categories = (
        ('time', 'internal time'),
        ('cumulative', 'cumulative time'),
        ('calls', 'call count'),
        ('pcalls', 'primitive call count'),
        # ('file', 'file name'),
        ('nfl', 'name/file/line'),
        ('stdname', 'standard name'),
        ('name', 'function name'),
    )

    template = """
<html>
    <head><title>Profile for %(url)s</title></head>
    <style>
    form { overflow: auto; border-bottom: solid 1px #999; padding-bottom: 1em; }
    fieldset { border: solid 1px #999; float: left; margin-right: 1em; }
    legend { font-weight: bold; }
    </style>
    <body>
        <form method='post' action='#top'>
            <input type='hidden' name='csrfmiddlewaretoken' value='%(csrf)s'>
            <fieldset>
                <legend>Sort by</legend>
                %(sort_first_buttons)s
            </fieldset>
            <fieldset>
                <legend>then by</legend>
                %(sort_second_buttons)s
            </fieldset>
            <fieldset>
                <legend>Format</legend>
                %(format_buttons)s
            </fieldset>
            <input type='hidden' name='__prof__stats' value='%(rawstats)s'>
            <input type='submit' name='sort' value='Sort'>
            <br><a href="%(url)s">Refresh</a>
        </form>
        <p id='stats'><strong>All</strong> &middot; <a href='#by_file'>By file</a>
            &middot; <a href='#by_group'>By group</a></p>
        <pre>%(stats)s</pre>
    </body>
</html>
"""

    def __init__(self, stats):
        self.stats = stats

    def display(self, request):
        sort = [
            request.REQUEST.get('sort_first', 'time'),
            request.REQUEST.get('sort_second', 'calls')]
        format = request.REQUEST.get('format', 'print_stats')

        sort_first_buttons = RadioButtons('sort_first', sort[0], self.sort_categories)
        sort_second_buttons = RadioButtons('sort_second', sort[1], self.sort_categories)
        format_buttons = RadioButtons(
            'format', format,
            (('print_stats', 'by function'),
             ('print_callers', 'by callers'),
             ('print_callees', 'by callees')))

        output = self.render(sort, format)

        response = HttpResponse(mimetype='text/html; charset=utf-8')
        response.content = (self.template % {
            'format_buttons': format_buttons,
            'sort_first_buttons': sort_first_buttons,
            'sort_second_buttons': sort_second_buttons,
            'rawstats': self.pickle(),
            'stats': output,
            'csrf': get_token(request),
            'url': request.get_full_path(),
        })

        if format == 'print_stats':
            response.content += self.summary_for_files(output)

        return response

    def render(self, sort, format):
        """
        _sort_ is a list of fields to sort by.
        _format_ is the name of the method that pstats uses to format the data.
        """
        output = StringIO.StringIO()
        if hasattr(self.stats, "stream"):
            self.stats.stream = output
        self.stats.sort_stats(*sort)
        getattr(self.stats, format)()
        return html.escape(output.getvalue())

    # Extra bits for summary by file/group

    group_prefix_re = [
        re.compile("^.*/django/[^/]+"),
        re.compile("^(.*)/[^/]+$"),  # extract module path
        re.compile(".*"),            # catch strange entries
    ]
    words_re = re.compile(r'\s+')

    def get_group(self, file):
        for g in self.group_prefix_re:
            name = g.findall(file)
            if name:
                return name[0]

    def get_summary(self, results_dict, sum):
        list = [(item[1], item[0]) for item in results_dict.items()]
        list.sort(reverse=True)
        list = list[:40]

        res = "      tottime\n"
        for item in list:
            res += "%4.1f%% %7.3f %s\n" % (
                100 * item[0] / sum if sum else 0, item[0], item[1])

        return res

    def summary_for_files(self, stats_str):
        stats_str = stats_str.split("\n")[5:]

        mystats = {}
        mygroups = {}

        sum = 0

        for s in stats_str:
            fields = self.words_re.split(s)
            if len(fields) == 7:
                time = float(fields[2])
                sum += time
                file = fields[6].split(":")[0]

                if file not in mystats:
                    mystats[file] = 0
                mystats[file] += time

                group = self.get_group(file)
                if group not in mygroups:
                    mygroups[group] = 0
                mygroups[group] += time

        return "<p id='by_file'><a href='#stats'>All</a> &middot; <strong>By file</strong> &middot; <a href='#by_group'>By group</a></p>\n" + \
               "<pre>" + self.get_summary(mystats, sum) + "</pre>\n" + \
               "<p id='by_group'><a href='#stats'>All</a> &middot; <a href='#by_file'>By file</a> &middot; <strong>By group</strong></p>\n" + \
               "<pre>" + self.get_summary(mygroups, sum) + "</pre>\n"

    # Pickling/unpicking functions

    def pickle(self):
        """Pickle a pstats.Stats object"""
        if hasattr(self.stats, "stream"):
            del self.stats.stream
        return b64encode(cPickle.dumps(self.stats))

    @classmethod
    def unpickle(cls, stats):
        """Unpickle a pstats.Stats object"""
        stats = b64decode(stats)
        stats = cPickle.loads(stats)
        stats.stream = True
        return cls(stats)


class RadioButton(object):
    """Generate the HTML for a radio button."""
    def __init__(self, name, value, description=None, checked=False):
        self.name = name
        self.value = value
        if description is None:
            self.description = value
        else:
            self.description = description
        self.checked = checked

    def __str__(self):
        checked = ""
        if self.checked:
            checked = " checked"
        return ("<label><input type='radio' "
                "name='%(name)s' value='%(value)s'"
                "%(checked)s> %(description)s</label>"
                "<br>" %
                {'name': self.name,
                 'value': self.value,
                 'checked': checked,
                 'description': self.description})


class RadioButtons(object):
    """Generate the HTML for a list of radio buttons."""
    def __init__(self, name, checked, values):
        self.result = []
        for v in values:
            description = None
            if isinstance(v, (list, tuple)):
                value = v[0]
                description = v[1]
            else:
                value = v
            select = False
            if value == checked:
                select = True
            self.result.append(RadioButton(name, value, description, select))

    def __str__(self):
        return "\n".join([str(button) for button in self.result])
