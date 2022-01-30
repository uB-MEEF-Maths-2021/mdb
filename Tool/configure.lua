#! /usr/bin/env texlua

local lfs = require("lfs")
local os = require("os")
local io = require("io")

local OS_TYPE = os["type"]
local OS_NAME = os["name"]
local IS_UNIX  = OS_TYPE == "unix"

local VERSION = "1.0"
local print = print
local exit = os.exit

local __FILE__ = arg[0]

local i = 1
local verbose = false

for _,r in ipairs(arg) do
  if r == "--verbose" then
    verbose = true
  elseif r == "-v" then
    verbose = true
  end
end
print("MathDataBase configure tool v"..VERSION)
if verbose then
  s = "Host operating system: %s (%s)"
  print(s:format(OS_TYPE, OS_NAME))
end

local mdb_Tool, mdb_root, mdb_Style
mdb_Tool = __FILE__:match(IS_UNIX and "(.*)/" or "(.*)[/\\]")
if mdb_Tool == nil then
  mdb_Tool = lfs.currentdir()
else
  if IS_UNIX then
    if not mdb_Tool:match("^/") then
      mdb_Tool = lfs.currentdir() .."/".. mdb_Tool
    end
  else
    if not mdb_Tool:match("^%u:") then
      mdb_Tool = lfs.currentdir() .."\\".. mdb_Tool
    end
  end
end
mdb_root = mdb_Tool:match(IS_UNIX and "(.*)/" or "(.*)[/\\]")
mdb_Style = mdb_root .."/Style"
if verbose then
  s = "MathDataBase location: %s"
  print(s:format(mdb_root))
end

local function is_directory(path)
  local mode,err_msg,err_code = lfs.attributes (path, "mode")
  return mode == "directory",err_msg,err_code
end

-- Test if we can make soft links
local destination = os.tmpname()
local err_msg, err_code
_, err_msg, err_code = lfs.attributes (destination, "mode")
if err_msg ~= nil then
  print("Soft link test: destination error", err_msg)
  exit(err_code)
end
local link_name = os.tmpname()
_, err_msg, err_code = os.remove(link_name)
if err_msg ~= nil then
  print("Cannot remove a temporary file", err_msg)
  exit(err_code)
end
_, err_msg, err_code = lfs.link(destination,link_name,true)
if err_msg ~= nil then
  print("Soft link test: link error", err_msg)
  if not IS_UNIX then
    print("Sur Windows, vous devez d'abord activer le mode développeur")
  end
  exit(err_code)
end
if verbose then
  print("Soft links available")
end
_, err_msg, err_code = lfs.attributes (link_name, "mode")
if err_msg ~= nil then
  print("Soft link test: link error", err_msg)
  if not IS_UNIX then
    print("Sur Windows, vous devez d'abord activer le mode développeur")
  end
  exit(err_code)
end
-- Where is the local texmf
local HOME
if IS_UNIX then
  HOME = os.getenv("HOME")
else
  HOME = os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH")
end
if verbose then
  print("HOME: "..HOME)
end
local function capture(cmd)
  local f = assert(io.popen(cmd,'r'))
  local s = assert(f:read('a'))
  f:close()
  return s
end
local TEXMFHOME = capture("kpsewhich --var-value=TEXMFHOME"):gsub('[\n\r]+', '')
local TEXMFHOME_ok = is_directory(TEXMFHOME)
if not TEXMFHOME_ok then
  local dir = TEXMFHOME:match(".*/")
  if dir then
    TEXMFHOME_ok = is_directory(dir) or lfs.mkdir(TEXMFHOME)
  else
    print("Votre dossier texmf personnel ne semble pas configuré")
    if not IS_UNIX then
      print("Sur MikTeX, voir le dernier paragraphe de https://miktex.org/kb/texmf-roots")
    end
    print("Quel est le chemin vers votre dossier texmf personnel?")
    local MAX = 3
    while true do
      TEXMFHOME = io.read()
      if TEXMFHOME:len() == 0 then
        print("Annulation")
        exit(1)
      end
      TEXMFHOME_ok = is_directory(TEXMFHOME)
      if TEXMFHOME_ok then
        break
      else
        print("Pas de dossier "..TEXMFHOME)
        if MAX > 0 then
          MAX = MAX - 1
        else
          print("Annulation")
          exit(1)
        end
      end
    end
  end
end
if verbose then
  print("Personal texmf tree: ".. TEXMFHOME)
end
TEXMFHOME_tex = TEXMFHOME.."/tex"
TEXMFHOME_tex_latex = TEXMFHOME_tex.."/latex"
if TEXMFHOME_ok then
  if (is_directory(TEXMFHOME_tex)
  or lfs.mkdir(TEXMFHOME_tex))
  and (is_directory(TEXMFHOME_tex_latex)
  or lfs.mkdir(TEXMFHOME_tex_latex)) then
    -- print("Votre dossier texmf personnel est\n"..TEXMFHOME)
  else
    print("Votre dossier texmf personnel semble être\n"..TEXMFHOME)
    print("Mais il manque le dossier\n"..TEXMFHOME_tex_latex)
  end
end
-- Configure MathDataBase
os.remove(TEXMFHOME_tex_latex.."/MDB.cfg")
if verbose then
  print("Removed "..TEXMFHOME_tex_latex.."/MDB.cfg")
end
local fh = assert(io.open(TEXMFHOME_tex_latex.."/MDB.cfg","w"))
local s = [[
%% MathDataBase configuration file: DO NOT EDIT
{
  path={%s},
}
]]
fh:write(s:format(mdb_Style))
fh:close()

fh = assert(io.open(TEXMFHOME_tex_latex.."/MDB.cfg","r"))
s = fh:read("a")
fh:close()
assert(s:match("MathDataBase"))
if verbose then
  print("Created "..TEXMFHOME_tex_latex.."/MDB.cfg:")
  print(s)
end
fh = assert(io.open(mdb_Style.."/MathDataBase.sty","r"))
s = fh:read("a")
fh:close()
if not s:match("MathDataBase") then
  print("Échec: MathDataBase est corrompu")
  exit(1)
end
os.remove(TEXMFHOME_tex_latex.."/MDB")
if verbose then
  print("Removed "..TEXMFHOME_tex_latex.."/MDB")
end
_, err_msg, err_code = lfs.link(mdb_Style, TEXMFHOME_tex_latex.."/MDB", true)
if err_msg ~= nil then
  print("Échec", err_msg)
  exit(err_code)
end
fh = assert(io.open(TEXMFHOME_tex_latex.."/MDB/MathDataBase.sty","r"))
s = fh:read("a")
fh:close()
if s:len() == 0 then
  print("Échec")
  exit(1)
end
if verbose then
  print("Created link "..TEXMFHOME_tex_latex.."/MDB -> "..mdb_Style)
end
s = capture("kpsewhich MathDataBase.sty")
if verbose then
  print("kpsewhich MathDataBase.sty: "..s)
end
if s:match("MathDataBase.sty") then
  print([[
Configuration réussie: vous pouvez utiliser
\RequirePackage{MathDataBase}
dans vos documents LaTeX.]])
else
  print("Échec de la configuration automatique")
end

