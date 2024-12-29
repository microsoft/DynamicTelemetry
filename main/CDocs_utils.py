import os

# Tips:
# import CDocs_utils as CDocs
# import importlib
# importlib.reload(CDocs)

def Include(baseDir, inputFile, startToken, endToken):
    "Include..."

    inputFile = os.path.join(baseDir, inputFile)

    with open(inputFile, 'r') as file:
        content = file.read()
        start = content.find(startToken)
        end = content.find(endToken)

        if(start == -1):
            raise Exception("Start token not found in file " + inputFile)

        if(end == -1):
            raise Exception("End token not found in file " + inputFile)

        start += len(startToken)
        return content[start:end]