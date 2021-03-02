import csv


class LabeledList:
    indeces = []
    values = None

    def __init__(self, data=None, index=None):
        self.values = data
        if index is None:
            for i in range(len(self.values)):
                self.indeces.append(i)
        else:
            self.indeces = index
            return

    def __str__(self):
        vals_max_len = []
        returnable_ll = ''
        nl = '\n'
        for i in range(len(self.values)):
            vals_max_len.append(len(str(self.values[i])) + 1 + len(str(self.indeces[i])))
        format_spec = f'>{max(vals_max_len)}'
        for i in range(len(self.values)):
            returnable_ll += f'{str(self.indeces[i]) + " " + str(self.values[i]):{format_spec}}' + nl
        return returnable_ll

    def __repr__(self):
        return repr(self.__str__())

    def __getitem__(self, key_list):
        if isinstance(key_list, LabeledList):
            key_list = key_list.values
        if isinstance(key_list, list):
            values = []
            indeces = []
            if type(key_list[0]) == bool:
                for i in range(len(self.values)):
                    if key_list[i]:
                        values.append(self.values[i])
                        indeces.append(self.indeces[i])
                return LabeledList(values, indeces)
            else:
                for j, i in enumerate(list(self.indeces)):
                    if i in key_list:
                        values.append(self.values[j])
                        indeces.append(self.indeces[j])
                return LabeledList(values, indeces)
        values = []
        indeces = []
        for j, i in enumerate(list(self.indeces)):
            if i in key_list:
                values.append(self.values[j])
                indeces.append(self.indeces[j])
        newll = LabeledList(values, indeces)
        if len(newll.values) == 1:
            return newll.values
        else:
            return newll

    def __iter__(self):
        self.x = 1
        return self

    def __next__(self):
        if self.x <= len(self.values):
            value = self.x
            self.x += 1
            return self.values[value - 1]
        else:
            raise StopIteration

    def __eq__(self, scalar):
        new_values = [i == scalar for i in self.values]
        return LabeledList(new_values, self.indeces)

    def __ne__(self, scalar):
        new_values = [i != scalar for i in self.values]
        return LabeledList(new_values, self.indeces)

    def __gt__(self, scalar):
        new_values = [i > scalar for i in self.values]
        return LabeledList(new_values, self.indeces)

    def __lt__(self, scalar):
        new_values = [i < scalar for i in self.values]
        return LabeledList(new_values, self.indeces)

    def map(self, f):
        new_values = [f(i) for i in self.values]
        return LabeledList(new_values)


class Table:
    data = None
    index = []
    columns = []

    def __init__(self, data, index=None, columns=None):
        self.data = data
        if index is None:
            for i in range(len(data)):
                self.index.append(i)
        else:
            self.index = index
        if columns is None:
            for i in range(len(data[0])):
                self.columns.append(i)
        else:
            self.columns = columns

    def __str__(self):
        table_str = '\n'
        row_format = "{:>50}" * (len(self.columns) + 1)
        table_str += (row_format.format("", *self.columns))
        for index, row in zip(self.index, self.data):
            table_str += '\n' + (row_format.format(str(index), *row))
        return table_str

    def __repr__(self):
        return repr(self.__str__())

    def head(self, n):
        table_str = ''
        row_format = "{:>50}" * (len(self.columns) + 1)
        table_str += (row_format.format("", *self.columns))
        counter = 0
        for index, data in zip(self.index, self.data):
            table_str += '\n' + (row_format.format(index, *data))
            counter += 1
            if counter == n:
                break
        return table_str

    def tail(self, n):
        table_str = ''
        empty_str = ''
        row_format = "{:>50}" * (len(self.columns) + 1)
        table_str += (row_format.format("", *self.columns))
        counter = 0
        for index, data in zip(self.index, self.data):
            empty_str += ''
            counter += 1
            if counter >= len(self.index) - n + 1:
                table_str += '\n' + (row_format.format(str(index), *data))
        return table_str

    def shape(self):
        shape = (len(self.data), len(self.columns))
        return shape

    def __getitem__(self, col_list):
        data = []
        if isinstance(col_list, LabeledList):
            col_list = col_list.values
        if isinstance(col_list, list):
            indexabledata = []
            if type(col_list[0]) == bool:
                indexablerow = []
                for i in range(len(col_list)):
                    if col_list[i]:
                        indexablerow.append(i)
                indexabledata = ([self.data[i] for i in indexablerow])
                indices = [list(self.index)[i] for i in indexablerow]
                return Table(indexabledata, indices, self.columns)
            for i in self.columns:
                if i in col_list:
                    for j in range(len(col_list)):
                        indexabledata.append(list(self.columns).index(col_list[j]))
            indexabledata = indexabledata[:len(indexabledata) - int(len(indexabledata) / 2)]
            for i in range(len(self.data)):
                curdata = list(self.data[i])
                data.append([curdata[x] for x in indexabledata])
            return Table(data, self.index, col_list)
        else:
            if col_list in self.columns:
                repeat_indexing = [i for i, x in enumerate(self.columns) if x == col_list]
                if len(repeat_indexing) > 1:
                    duplicate_data = []
                    for i in range(len(self.data)):
                        duplicate_data.append([list(self.data[i])[x] for x in repeat_indexing])
                    return Table(duplicate_data, self.index, [col_list] * len(repeat_indexing))
                indexabledata = list(self.columns).index(col_list)
                for i in range(len(self.data)):
                    curdata = list(self.data[i])
                    data.append(curdata[indexabledata])
                return LabeledList(data, self.index)


def read_csv(fn):
    with open(fn, 'r') as f:
        reader = csv.reader(f)
        columns = next(reader)
        columns = columns[1:]
        indices = []
        data = [line.split(',') for line in f]
        actual_data = []
        for row in data:
            indices.append(row[0])
            row_data = []
            for element in range(len(row)):
                try:
                    flt = float(row[element])
                except ValueError:
                    flt = row[element]
                    pass
                row_data.append(flt)
            actual_data.append(row_data)
        for i in actual_data:
            del i[0]
        return Table(actual_data, indices, columns)


if __name__ == '__main__':
    flt = pow(.99, 520)
    print(flt)


