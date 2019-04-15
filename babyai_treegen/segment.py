from enum import Enum
class SegmentType(Enum):
    COMMAND = 1
    OBJECT = 2
    PUTSPEC = 3

commands = [
    'put',
    'go',
    'pick',
    'open'
]

objects = [
    'ball',
    'key',
    'box'
]

class Segment():
    def __init__(self, words):
        self.words = words
        for word in words:
            if word in commands:
                self.type = SegmentType.COMMAND
                break
            elif word in objects:
                self.type = SegmentType.OBJECT
            else:
                self.type = SegmentType.PUTSPEC
    def __repr__(self):
        return f"{self.type} - {self.words}"

    def __hash__(self):
        return hash(str(self.words))

    def __eq__(self, other):
        _words = self.words == other.words
        _type = self.type == other.type
        return _words and _type