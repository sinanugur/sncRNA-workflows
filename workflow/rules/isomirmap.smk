from collections import defaultdict
#directories, files, = glob_wildcards("data/raw/{samplegroup}/{sample}.fastq.gz")

#files, = glob_wildcards("data/{sample}.fastq.gz")

include: "bowtie2.smk"
#gene=['tRF']

'''
@author: Sinan U. Umu, PhD, sinanugur@gmail.com
'''


rule isomir_derived_by_isomirmap:
        input:
            "analyses/trimmed/{sample}.trimmed.fastq.gz"

        output: 
            "analyses/isoMiRmap/{sample}-IsoMiRmap_v5-exclusive-isomiRs.expression.txt",
            "analyses/isoMiRmap/{sample}-IsoMiRmap_v5-ambiguous-isomiRs.expression.txt",
            "analyses/isoMiRmap/{sample}-IsoMiRmap_v5-snps-isomiRs.expression.txt"
            

        shell:
            """
		input_name=$(basename {input})
		samplename=${{input_name/.trimmed.fastq.gz/}}

        isoMiRmap/IsoMiRmap.py {input} --m ./isoMiRmap/MappingBundles/miRBase/ --p analyses/isoMiRmap/"$samplename"

            """

rule isomir_txt_tables:
    input:
        "analyses/isoMiRmap/{sample}-IsoMiRmap_v5-exclusive-isomiRs.expression.txt",
        "analyses/isoMiRmap/{sample}-IsoMiRmap_v5-ambiguous-isomiRs.expression.txt",
        "analyses/isoMiRmap/{sample}-IsoMiRmap_v5-snps-isomiRs.expression.txt"
    output:
        "analyses/isoMiRmap/txt_tables_per_file/{sample}.isomirmap.txt"
    shell:
        """
        input_name=$(basename {input[0]})
		samplename=${{input_name/-IsoMiRmap_v5-exclusive-isomiRs.expression.txt/}}
        cat {input[0]} {input[1]} | grep -v "^#" | gawk -v s=$samplename 'BEGIN{{print "ID\t"s}}!/License/{{print $1"\t"$4}}' > {output};
        cat {input[2]} | grep -v "^#" | gawk '!/License/{{print $1"\t"$3}}' >> {output};
        """



rule create_isomirmap_count_tables:
        input:
            lambda wildcards : ["analyses/isoMiRmap/txt_tables_per_file/" + s + ".isomirmap.txt" for s in files]

        output:
            "results/count_tables/isomiR.tsv"

        shell:
            """
		for i in {input}; do echo $i; done > analyses/isoMiRmap/tmp.csv
		Rscript --no-environ ./workflow/scripts/sncrna_table_creator.R {output} analyses/isoMiRmap/tmp.csv

                rm analyses/isoMiRmap/tmp.csv
            """


