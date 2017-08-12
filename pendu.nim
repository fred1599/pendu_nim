import streams
import math
import strutils

proc word_seq(w: string): seq[char] =
    var s: seq[char] = @[]
    for c in w:
        s.add('*')
    return s

proc display(s: seq[char]) =
    var res = ""
    for i in s:
        res.add(i)
    echo res

proc search(s: seq[char], w: string, c: char): seq[char] =
    let n: int = len(w)
    var res: seq[char] = @[]
    for i in 0..n-1:
        if w[i] == c and s[i] == '*':
            res.add(c)
        else:
            res.add(s[i])
    return res

proc compare(s:seq[char], w:string): bool =
    let n: int = len(w)
    for i in 0..n-1:
        if w[i] != s[i]:
            return false
    return true

var
    lines: seq[string] = @[]
    line = ""
    word: string
    secret: seq[char]
    mychar: char

const
    path = r"/home/fred1599/Bureau/dico.txt"

let
    f = newFileStream(path, fmRead)

# Initializes the random number generator
randomize()

# add line by line the content of f
while f.readLine(line):
    lines.add(line)

word = random(lines)
secret = word_seq(word)
while not compare(secret, word):
    display(secret)
    echo "Entrez votre caractère: "
    mychar = readLine(stdin)[0]
    secret = search(secret, word, mychar)
display(secret)
