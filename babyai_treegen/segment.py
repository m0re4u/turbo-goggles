from enum import Enum
class SegmentType(Enum):
    COMMAND = 1
    OBJECT = 2
    PUTOBJECT = 3
    VERB = 4
    NOUN = 5
    PROP = 6
    ARTICLE = 7

words_to_wordtype = {
    'put': SegmentType.VERB,
    'go':  SegmentType.VERB,
    'pick': SegmentType.VERB,
    'open': SegmentType.VERB,
    'ball': SegmentType.NOUN,
    'key':  SegmentType.NOUN,
    'box':  SegmentType.NOUN,
    'door':  SegmentType.NOUN,
    'red':  SegmentType.NOUN,
    'green':  SegmentType.NOUN,
    'blue':   SegmentType.NOUN,
    'purple': SegmentType.NOUN,
    'yellow': SegmentType.NOUN,
    'grey':   SegmentType.NOUN,
    'next': SegmentType.PROP,
    'to':   SegmentType.PROP,
    'a': SegmentType.ARTICLE,
    'the': SegmentType.ARTICLE
}

class Segment():
    def __init__(self, words, type):
        self.words = words
        self.type = type

    def __repr__(self):
        return f"{self.type:22} - {self.words}"

    def __hash__(self):
        return hash(str(self.words))

    def __eq__(self, other):
        _words = self.words == other.words
        _type = self.type == other.type
        return _words and _type

    def __format__(self, fmt):
        return format(str(self), fmt)

class Segmenter():
    def __init__(self, segment_level):
        self.level = segment_level

    def segment(self, instruction):
        instruction_list = instruction.split()
        if self.level == 'word':
            return [Segment(x, words_to_wordtype[x]) for x in instruction_list]
        elif self.level == 'segment':
            # Mission specific segmentation? (hardcore??)
            # This one is for PutNextLocal-v0
            cmd = instruction_list[:1]
            obj1 = instruction_list[1:4]
            locobj = instruction_list[4:]
            return [
                Segment(cmd, SegmentType.COMMAND),
                Segment(obj1, SegmentType.OBJECT),
                Segment(locobj, SegmentType.PUTOBJECT)
            ]
