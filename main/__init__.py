import CDocs_utils as CDocs
import os

def define_env(env):
    """
    This is the hook for the variables, macros and filters.
    """

    @env.macro
    def ProvideFeedback(page):
        "Feedback..."
        return "[Provide Feedback : " + page + "](http://bing.com)"

    @env.macro
    def ComingSoon(page):
        "Feedback..."
        return "[Coming Soon : " + page + "](http://bing.com)"

    @env.macro
    def Include(file, startToken, endToken):
        "Include..."
        baseDir = os.path.dirname(env.page.file.src_path)
        myDir = os.path.join(env.page.file.src_dir, baseDir)
        return CDocs.Include(myDir, file, startToken, endToken)