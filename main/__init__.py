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
    def XInclude(file, startToken, endToken, tabLeft=False):
        "Include..."
        baseDir = os.path.dirname(env.page.file.src_path)
        myDir = os.path.join(env.page.file.src_dir, baseDir)
        return CDocs.Include(myDir, file, startToken, endToken, tabLeft)

    @env.macro
    def CSharp_Include(file, startToken, endToken, tabLeft=True ):
        "Include..."
        baseDir = os.path.dirname(env.page.file.src_path)
        myDir = os.path.join(env.page.file.src_dir, baseDir)

        code = ""
        code +=  CDocs.Include(myDir, file, startToken, endToken, tabLeft)
        return code