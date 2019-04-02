import nltk

from nltk.parse import generate

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
    # print(len(list(gen)))
    for i, sent in enumerate(gen):
        print(f"{i:>3} - {sent}")


if __name__ == "__main__":
    main()