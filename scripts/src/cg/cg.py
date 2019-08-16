from git import Repo
from syspy import Directory

dir = Directory()


repo = Repo(dir.fromHome('.cfg'))

repo.git_dir = dir.fromHome('.cfg')
repo.working_dir = dir.home

print(repo.working_dir)
print(repo.git_dir)

# checkout -b new_branch
# repo.checkout(b='new_branch')

git = repo.git

# git.checkout('ubuntu')

print(git.status())