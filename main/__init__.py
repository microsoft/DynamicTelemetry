import CDocs_utils as CDocs

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
        return CDocs.Include(file, startToken, endToken)