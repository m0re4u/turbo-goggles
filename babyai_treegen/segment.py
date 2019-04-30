from enum import Enum


class SegmentType(Enum):
    COMMAND = 1
    OBJECT = 2
    PUTOBJECT = 3
    LOCSPEC = 4
    VERB = 5
    NOUN = 6
    PROP = 7
    ARTICLE = 8


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

colors = set([
    'red',
    'green',
    'blue',
    'purple',
    'yellow',
    'grey'
])


class SegmentHash():
    def __init__(self):
        self.max_size = 1000
        self.vocab = {}

    def __getitem__(self, key):
        if not (key in self.vocab.keys()):
            if len(self.vocab) >= self.max_size:
                raise ValueError("Maximum vocabulary capacity reached")
            self.vocab[key] = len(self.vocab) + 1
        return self.vocab[key]


hasher = SegmentHash()


class Segment():
    def __init__(self, words, type, append_segid=False):
        self.words = words
        self.type = type
        self.segid = append_segid

    def __repr__(self):
        if self.segid:
            l = [word + "_" + str(hasher[self]) for word in self.words]
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
    def __init__(self, mission, segment_level, append_segid=False):
        self.segment_level = segment_level
        self.mission = mission
        self.append_segid = append_segid

    def segment(self, instruction):
        instruction_list = instruction.split()
        if self.segment_level == 'word':
            return [Segment(x, words_to_wordtype[x], self.append_segid) for x in instruction_list]
        elif self.segment_level == 'segment':
            # Rule based segmentation based on level
            if self.mission == "BabyAI-PutNextLocal-v0":
                cmd = instruction_list[:1]
                obj1 = instruction_list[1:4]
                locobj = instruction_list[4:6]
                obj2 = instruction_list[6:]
                return [
                    Segment(cmd, SegmentType.COMMAND, self.append_segid),
                    Segment(obj1, SegmentType.OBJECT, self.append_segid),
                    Segment(locobj, SegmentType.PUTOBJECT, self.append_segid),
                    Segment(obj2, SegmentType.OBJECT, self.append_segid)
                ]
            elif (self.mission == "BabyAI-GoToLocal-v0" or
                  self.mission == "BabyAI-GoTo-v0"):
                cmd = instruction_list[:2]
                obj1 = instruction_list[2:]
                return [
                    Segment(cmd, SegmentType.COMMAND, self.append_segid),
                    Segment(obj1, SegmentType.OBJECT, self.append_segid)
                ]
            elif self.mission == "BabyAI-PickupLoc-v0":
                if len(colors & set(instruction_list)):
                    # colored object
                    obj_e = 5
                else:
                    # no color specifier for object
                    obj_e = 4
                cmd = instruction_list[:2]
                obj1 = instruction_list[2:obj_e]
                loc = instruction_list[obj_e:]
                if loc != []:
                    return [
                        Segment(cmd, SegmentType.COMMAND, self.append_segid),
                        Segment(obj1, SegmentType.OBJECT, self.append_segid),
                        Segment(loc, SegmentType.LOCSPEC, self.append_segid)
                    ]
                else:
                    return [
                        Segment(cmd, SegmentType.COMMAND, self.append_segid),
                        Segment(obj1, SegmentType.OBJECT, self.append_segid)
                    ]



