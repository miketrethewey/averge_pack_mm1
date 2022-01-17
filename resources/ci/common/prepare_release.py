import common
import distutils.dir_util     # for copying trees
import os                     # for env vars
import stat                   # for file stats
import subprocess             # do stuff at the shell level
from git_clean import git_clean
from shutil import copy, make_archive, move, rmtree  # file manipulation

def prepare_release():
  env = common.prepare_env()  # get env vars

  dirs = [
      os.path.join("..", "artifact"),   # temp dir for binary
      os.path.join("..", "build"),      # temp dir for other stuff
      os.path.join("..", "deploy")      # dir for archive
  ]
  for dirname in dirs:
      if not os.path.isdir(dirname):
          os.makedirs(dirname)

  # make dirs for each os
  # for dirname in ["linux", "macos", "windows"]:
  for dirname in ["linux"]:
      if not os.path.isdir(os.path.join("..", "deploy", dirname)):
          os.mkdir(os.path.join("..", "deploy", dirname))

  # sanity check permissions for working_dirs.json
  dirpath = "."
  for dirname in ["resources", "user", "meta", "manifests"]:
      dirpath += os.path.join(dirpath, dirname)
      if os.path.isdir(dirpath):
          os.chmod(dirpath, 0o755)

  # nuke git files
  for git in [ os.path.join(".", ".gitattrubutes"), os.path.join(".", ".gitignore") ]:
    if os.path.isfile(git):
      os.remove(git)

  # nuke travis file if it exists
  for travis in [
      os.path.join(
          ".",
          ".travis.yml"
      ),
      os.path.join(
          ".",
          ".travis.off"
      )
  ]:
      if os.path.isfile(travis):
          os.remove(travis)

  # nuke test suite if it exists
  if os.path.isdir(os.path.join(".", "tests")):
      distutils.dir_util.remove_tree(os.path.join(".", "tests"))

  BUILD_FILENAME = ""
  ZIP_FILENAME = ""

  # list executables
  BUILD_FILENAME = (os.path.join("."))
  if BUILD_FILENAME == "":
      BUILD_FILENAME = (os.path.join("..", "artifact"))

  if isinstance(BUILD_FILENAME, str):
      BUILD_FILENAME = list(BUILD_FILENAME)

  BUILD_FILENAMES = BUILD_FILENAME

  print(BUILD_FILENAMES)

  if len(BUILD_FILENAMES) > 0:
      # clean the git slate
      git_clean()

      # mv dirs from source code
      dirs = [
          os.path.join(".", ".git"),
          os.path.join(".", ".github"),
          os.path.join(".", ".gitattributes"),
          os.path.join(".", ".gitignore"),
          os.path.join(".", "html"),
          os.path.join(".", "resources"),
          os.path.join(".", "schemas"),
          os.path.join(".", "CODE_OF_CONDUCT.md")
      ]
      for dirname in dirs:
          if os.path.isdir(dirname):
              move(
                  dirname,
                  os.path.join("..", "build", dirname)
              )

      # .zip if windows
      # .tar.gz otherwise
      ZIP_FILENAME = os.path.join(
          "..",
          "deploy",
          env["REPO_NAME"]
      )
      make_archive(ZIP_FILENAME, "zip")
      ZIP_FILENAME += ".zip"

      # mv dirs back
      for thisDir in dirs:
          if os.path.isdir(os.path.join("..", "build", thisDir)):
              move(
                  os.path.join("..", "build", thisDir),
                  os.path.join(".", thisDir)
              )

  if not ZIP_FILENAME == "":
      print(f"Zip Filename:   {ZIP_FILENAME}")
      print("Zip Filesize:   " + common.file_size(ZIP_FILENAME))
  else:
      print(f"No Zip to prepare: {ZIP_FILENAME}")

  print(f"Git tag:        {env['GITHUB_TAG']}")

  if (ZIP_FILENAME == ""):
      exit(1)


def main():
  prepare_release()

if __name__ == "__main__":
  main()
else:
  raise AssertionError("Script improperly used as import!")
