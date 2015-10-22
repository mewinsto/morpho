outfile = open("ehamatum_SMC021.tps", 'w')

spec_label = 'ID=ehamatum_SMC021.'
index_begin = 1
index_end = 17
no_digits = 3

for i in range(index_begin,index_end):
    outfile.write("LM=14")
    outfile.write('\n' * 15)
    q = str(i)
    q = q.zfill(no_digits)
    label = spec_label + q
    outfile.write(label)
    outfile.write('\n')

    outfile.write("LM=14")
    outfile.write('\n' * 15)
    q =str(i)
    q =q.zfill(no_digits)
    label = spec_label + q + '.R'
    outfile.write(label)
    outfile.write('\n')

outfile.close()
