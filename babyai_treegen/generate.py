# -*- coding: utf-8 -*-
# Natural Language Toolkit: Generating from a CFG
#
# Copyright (C) 2001-2019 NLTK Project
# Author: Steven Bird <stevenbird1@gmail.com>
#         Peter Ljunglöf <peter.ljunglof@heatherleaf.se>
# URL: <http://nltk.org/>
# For license information, see LICENSE.TXT
#
from __future__ import print_function

import itertools
import sys
from graphviz import Digraph

from nltk.grammar import Nonterminal


def generate(grammar, g, start=None, depth=None, n=None):
    """
    Generates an iterator of all sentences from a CFG.

    :param grammar: The Grammar used to generate sentences.
    :param start: The Nonterminal from which to start generate sentences.
    :param depth: The maximal depth of the generated tree.
    :param n: The maximum number of sentences to return.
    :return: An iterator of lists of terminal tokens.
    """
    if not start:
        start = grammar.start()
    if depth is None:
        depth = sys.maxsize

    iter = _generate_all(grammar, [start], depth, g)

    if n:
        iter = itertools.islice(iter, n)

    return iter



def _generate_all(grammar, items, depth, g):
    # print(f"depth: {depth} - {items}")
    if items:
        try:
            for A, frag1 in _generate_one(grammar, items[0], depth, g):
                for symbs, frag2 in _generate_all(grammar, items[1:], depth, g):
                    words = frag1 + frag2
                    yield (A + symbs, words)
        except RuntimeError as _error:
            if _error.message == "maximum recursion depth exceeded":
                # Helpful error message while still showing the recursion stack.
                raise RuntimeError(
                    "The grammar has rule(s) that yield infinite recursion!!"
                )
            else:
                raise
    else:
        yield ([], [])


def _generate_one(grammar, item, depth, g):
    # print(f"one_depth: {depth} - {item}")
    if depth > 0:
        if isinstance(item, Nonterminal):
            for prod in grammar.productions(lhs=item):
                for symbs, frag in _generate_all(grammar, prod.rhs(), depth - 1, g):
                    yield ([item] + [symbs], frag)
        else:
            yield ([item], [item])


demo_grammar = """
  S -> NP VP
  NP -> Det N
  PP -> P NP
  VP -> 'slept' | 'saw' NP | 'walked' PP
  Det -> 'the' | 'a'
  N -> 'man' | 'park' | 'dog'
  P -> 'in' | 'with'
"""


def demo(N=2):
    from nltk.grammar import CFG

    print('Generating the first %d sentences for demo grammar:' % (N,))
    print(demo_grammar)
    grammar = CFG.fromstring(demo_grammar)
    G = Digraph()
    for n, sent in enumerate(generate(grammar, G, n=N), 1):
        print(f"s - {sent}")


if __name__ == '__main__':
    demo()