def define_env(env):
    """
    This is the hook for the variables, macros and filters.
    """

    @env.macro
    def ProvideFeedback(page):
        "Feedback..."
        return "[Provide Feedback : " + page + "](http://bing.com)"