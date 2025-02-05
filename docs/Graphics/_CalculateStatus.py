import glob
import re
from collections import defaultdict

review_status_counts = defaultdict(int)
fileinfo = defaultdict(list)
wordCounts = defaultdict(int)

review_status_counts["Level1"] = 0
review_status_counts["Level1b"] = 0
review_status_counts["Level2"] = 0
review_status_counts["Level3"] = 0
review_status_counts["Level4"] = 0
review_status_counts["Level15"] = 0


for(file) in glob.glob("../docs/*.md"):
    with open(file, "r") as f:
        data = f.read()

        # Generate wordcount
        wordCounts[file] = len(data.split())

        pattern = r'status: Review(.*?)\n'
        matches = re.findall(pattern, data, re.DOTALL)

        for(match) in matches:
            fileinfo[match].append(file)
            review_status_counts[match.strip()] += 1
            break # Only print the first match


with open("./Status.csv", "w") as f:
    print("State, Count", file=f)
    for (key, value) in review_status_counts.items():
        print(key + "," + str(value), file=f)

with open("../docs/GeneratedFileStatus.md", "w") as f:
    print("---", file=f)
    print("author: Generated File", file=f)
    print("status: Level5", file=f)
    print("---", file=f)

    for (status, files) in fileinfo.items():
        print("## " + status, file=f)
        print("", file=f)
        print("| File | Word Count |", file=f)
        print("|------|------------|", file=f)
        for(file) in files:
            print("| [" + file + "](" + file + ")  | " + str(wordCounts[file]) + "|", file=f)

        print("\n", file=f)

