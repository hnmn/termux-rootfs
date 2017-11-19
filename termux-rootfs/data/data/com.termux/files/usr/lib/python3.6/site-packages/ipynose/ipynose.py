import subprocess


def show_all_nose_results():
    print(all_nose_results())


def show_nose_result(module_path=""):
    print(nose_result(module_path))


def all_nose_results():
    out, err = subprocess.Popen(
            ['nosetests', '-v'],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
            ).communicate()
    return err.decode("utf-8")


def nose_result(module_path=""):
    """
    module_path could be a file name
    """
    out, err = subprocess.Popen(
            ['nosetests', '-v', module_path],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
            ).communicate()
    return err.decode("utf-8")
