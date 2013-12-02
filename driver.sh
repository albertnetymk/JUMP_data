#!/bin/bash
for d in *; do
    if [ -d $d ]; then
        echo $d
        cd $d
        buffers=($(head -n 1 header.md | sed 's!|! !g'))

        cd local
        cat /dev/null > ${d}.txt
        for v in 1 2 3; do
            for bz in ${buffers[@]}; do
                if [ -f v${v}_${bz}.m ]; then
                    octave -q v${v}_${bz}.m >> ${d}.txt
                fi
            done
        done
        perl ../../test.pl ${d}.txt > unzip.txt
        lines=$(cat unzip.txt | wc -l)
        half=$(( $lines / 2 ))
        head -n $half unzip.txt > mean.txt
        tail -n $half unzip.txt > std.txt
        cd ..

        cd remote
        cat /dev/null > ${d}.txt
        for v in 1 2 3; do
            for bz in ${buffers[@]}; do
                if [ -f v${v}_${bz}.m ]; then
                    octave -q v${v}_${bz}.m >> ${d}.txt
                fi
            done
        done
        perl ../../test.pl ${d}.txt > unzip.txt
        lines=$(cat unzip.txt | wc -l)
        half=$(( $lines / 2 ))
        head -n $half unzip.txt > mean.txt
        tail -n $half unzip.txt > std.txt
        cd ..

        # merge local and remote statistics
        cat remote/mean.txt local/mean.txt > mean.txt
        cat remote/std.txt local/std.txt > std.txt

        # construct table
        echo '## mean' > table.md
        cat header.md >> table.md
        perl ../table.pl ${#buffers[@]} mean.txt >> table.md

        echo '## standard deviation' >> table.md
        cat header.md >> table.md
        perl ../table.pl ${#buffers[@]} std.txt >> table.md

        cd ..
    fi
done
