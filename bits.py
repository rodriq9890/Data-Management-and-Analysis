class DecodeError(Exception):
    pass


class ChunkError(Exception):
    pass


class BitList(object):
    def __eq__(self, other):
        return self.UserInput == other

    def __str__(self):
        return self.GetString()

    def __init__(self, InitialInput):
        BinList = []
        BinSet = {'0', '1', 0, 1}
        for i in InitialInput:
            if i not in BinSet:
                raise ValueError("'Format is invalid; does not consist of only 0 and 1'")
            else:
                BinList.append((int(i)))
        self.UserInput = BinList
        return

    @staticmethod
    def from_ints(*args):
        for arg in args:
            if int(arg) not in range(0, 2):
                raise ValueError('Format is invalid; does not consist of only 0 and 1')
        return BitList(args)

    def arithmetic_shift_left(self):
        self.UserInput.pop(0)
        self.UserInput.append(0)

    def arithmetic_shift_right(self):
        self.UserInput.pop()
        self.UserInput.insert(0, self.UserInput[0])

    def bitwise_and(self, otherBitList):
        CurList = self.GetList()
        InputList = otherBitList.GetList()
        NewList = []
        if len(CurList) != len(InputList):
            raise Exception("Input binary strings are of different lengths")
        for i in range(len(CurList)):
            NewList.append(CurList[i] * InputList[i])
        return BitList(NewList)

    def GetList(self):
        return [int(i) for i in self.UserInput]

    def GetString(self):
        return ''.join(str(i) for i in self.GetList())

    def chunk(self, chunk_length):
        CurList = self.GetList()
        ChunkList = []
        if len(CurList) % chunk_length != 0:
            raise ChunkError("Given Chunk length is not evenly divisible")
        for i in range(0, len(CurList), chunk_length):
            ChunkList.append(CurList[i:i + chunk_length])
        return ChunkList

    def decode(self, encoding='utf-8'):
        if encoding not in {'utf-8', 'us-ascii'}:
            raise ValueError("Encoding not supported")
        if len(self.GetList()) == 8 and self.GetList()[0] == 1:
            raise DecodeError('Invalid Leading Byte')
        if len(self.GetList()) <= 8:
            return chr(int(self.GetString(), 2))
        ChunkQuantity = round(len(self.GetList()) / 8)
        ChunkList = self.chunk(len(self.GetList()) // ChunkQuantity)
        CharString = ''
        if encoding == 'us-ascii':
            for i in ChunkList:
                result = int("".join(str(j) for j in i), 2)
                CharString += chr(result)
            return CharString
        if encoding == 'utf-8' and ChunkQuantity >= 2:
            for Count, Chunk in enumerate(ChunkList):
                if Count == 0 and ChunkQuantity == 2:
                    if ChunkList[Count][0:3] != [1, 1, 0] and ChunkList[Count + 1][0:2] != [1, 0]:
                        raise DecodeError("Invalid Continuation Bit in Byte Sequence")
                if ChunkQuantity == 3 and ChunkList[0][0:4] != [1, 1, 1, 0] \
                        or ChunkList[1][0:2] != [1, 0] or ChunkList[2][0:2] != [1, 0]:
                    raise DecodeError("Invalid Continuation Bit in Byte Sequence")
                if ChunkQuantity == 4 and (ChunkList[0][0:5] != [1, 1, 1, 1, 0] or ChunkList[1][0:2] != [1, 0] or
                                           ChunkList[2][0:2] != [1, 0] or ChunkList[3][0:2] != [1, 0]):
                    raise DecodeError("Invalid Continuation Bit in Byte Sequence")
        return bytes.fromhex('%x' % int(self.GetString(), 2)).decode('utf-8')