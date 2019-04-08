import nltk
from graphviz import Digraph
import generate

def main():
    grammar = nltk.CFG.fromstring("""
        Sent -> Sent1
        Sent1 -> Clause
        Clause -> 'go to' Descr | 'pick up' DescrNotDoor | 'open' DescrDoor | 'put' DescrNotDoor 'next to' Descr
        DescrDoor -> Article Color 'Door' LocSpec
        DescrBall -> Article Color 'ball' LocSpec
        DescrBox -> Article Color 'box' LocSpec
        DescrKey -> Article Color 'key' LocSpec
        Descr -> DescrDoor | DescrBall | DescrBox | DescrKey
        DescrNotDoor -> DescrBall | DescrBox | DescrKey
        LocSpec -> 'on your left' | 'on your right' | 'in front of you' | 'behind you' | 'NOLOC'
        Color -> 'red' | 'green' | 'blue' | 'purple' | 'yellow' | 'grey' | 'NOCOLOR'
        Article -> 'the' | 'a'
    """)
    # print(grammar.productions())

    gen = generate.generate(grammar)
    G = Digraph(comment='single tree')
    for i, sent in enumerate(gen, 1):
        print(f"{i:>3} - {sent}")

        print(sent[0])
        a = expand(sent[0], G)
        exit()

def expand(items, g):
    print(items)
    l, *r = items
    g.node(str(l), str(l))
    for el in r:
        print(f"el: {el}")
        expand(el, g)
        # g.node(str(l), str(l))
        # g.edge(str(l), str)


if __name__ == "__main__":
    main()