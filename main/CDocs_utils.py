import os
import random
import re

# Tips:
# ------------------------------------------------------------------------------
# import CDocs_utils as CDocs
# import importlib
# importlib.reload(CDocs)

def count_leading_spaces(input_string):
    return len(input_string) - len(input_string.lstrip(' '))


def RemoveImageWithAndHeightInfo(text):
    # Regular expression to remove text between { and }
    pattern = r'\{width.*?height.*?}'
    return re.sub(pattern, '', text, flags=re.DOTALL)


def Include(baseDir, inputFile, startToken, endToken, tabLeft):
    "Include..."

    inputFile = os.path.join(baseDir, inputFile)

    with open(inputFile, 'r') as file:
        content = file.read()
        start = content.find(startToken)
        end = content.find(endToken)

        if(start == -1):
            raise Exception("Start token [" + startToken + "] not found in file " + inputFile)

        if(end == -1):
            raise Exception("End token [" + endToken + "] not found in file " + inputFile)

        start += len(startToken)

        clip = content[start:end]

        if not tabLeft:
            return clip

        toChop = 999999999
        for line in clip.split('\n'):
            if(len(line) == 0):
                continue
            spaces = count_leading_spaces(line)

            if(toChop > spaces):
                toChop = spaces

        ret = ""
        for line in clip.split('\n'):
            if(len(line) == 0):
                ret += line
                ret += '\n'
                continue

            ret += line[toChop:]
            ret += '\n'

        # print("Length of clip: " + str(len(clip)) + " and ret: " + str(len(ret)))
        return ret
