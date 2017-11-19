from dis import dis
from IPython.core.magic import Magics, magics_class, line_cell_magic


@magics_class
class DisMagics(Magics):

    @line_cell_magic
    def dis(self, line, cell=None):
        """ %dis magic command for ipython """
        dis(cell or self.shell.user_ns.get(line, line))


def load_ipython_extension(ip):
    """Load the extension in IPython."""
    dis_magic = DisMagics(ip)
    ip.register_magics(dis_magic)
