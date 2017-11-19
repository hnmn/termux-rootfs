django-profiler-middleware
==========================

This piece of middleware enables you to see the profiler output for any URL by
adding a parameter to it. It then lets you reorder the profiler output without
having to recalculate.

Installation
------------

    $ pip install django-profiler-middleware

Then add ``django_profiler.middleware.ProfilerMiddleware`` to the end of your
``MIDDLEWARE_CLASSES``, and then add ``__prof__`` to your URL.


