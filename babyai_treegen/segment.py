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
    def __init__(self, words, type, append_segid=False):
        self.words = words
        self.type = type
        self.segid = append_segid

    def __repr__(self):
        if self.segid:
            l = [word + "_" + str(hash(self)) for word in self.words]
        else:
            l = self.words
        sent = " ".join(l)
        return sent

    def __hash__(self):
        return hash(str(self.words))

    def __eq__(self, other):
        _words = self.words == other.words
        _type = self.type == other.type
        return _words and _type

    def __format__(self, fmt):
        return format(str(self), fmt)


class Segmenter():
    def __init__(self, mission, segment_level):
        self.segment_level = segment_level
        self.mission = mission

    def segment(self, instruction):
        instruction_list = instruction.split()
        if self.segment_level == 'word':
            return [Segment(x, words_to_wordtype[x]) for x in instruction_list]
        elif self.segment_level == 'segment':
            if self.mission == "BabyAI-PutNextLocal-v0":
                cmd = instruction_list[:1]
                obj1 = instruction_list[1:4]
                locobj = instruction_list[4:]
                return [
                    Segment(cmd, SegmentType.COMMAND),
                    Segment(obj1, SegmentType.OBJECT),
                    Segment(locobj, SegmentType.PUTOBJECT)
                ]
            elif (self.mission == "BabyAI-GoToLocal-v0" or
                  self.mission == "BabyAI-PickupLoc-v0" or
                  self.mission == "BabyAI-GoTo-v0"):
                cmd = instruction_list[:2]
                obj1 = instruction_list[2:]
                return [
                    Segment(cmd, SegmentType.COMMAND),
                    Segment(obj1, SegmentType.OBJECT)
                ]
