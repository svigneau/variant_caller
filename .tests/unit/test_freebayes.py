import os
import sys

import subprocess as sp
from tempfile import TemporaryDirectory
from tempfile import NamedTemporaryFile  # added manually
import shutil
from pathlib import Path, PurePosixPath


sys.path.insert(0, os.path.dirname(__file__))

import common

def remove_second_line_from_file(file_path):  # added manually
    
    temp_path = None
    
    with open(file_path, 'r') as f_in:
        with NamedTemporaryFile(mode='w', delete=False) as f_out:
            temp_path = f_out.name
            f_out.write(next(f_in))  # write first line
            next(f_in)  # skip second line
            for line in f_in:
                f_out.write(line)
    
    os.remove(file_path)
    shutil.move(temp_path, file_path)

def test_freebayes():

    with TemporaryDirectory() as tmpdir:
        workdir = Path(tmpdir) / "workdir"
        data_path = PurePosixPath(".tests/unit/freebayes/data")
        expected_path = PurePosixPath(".tests/unit/freebayes/expected")
        config_path = PurePosixPath(".tests/unit/config")  # added manually

        # Copy data to the temporary workdir.
        shutil.copytree(data_path, workdir)
        shutil.copytree(config_path, workdir / "config")  # added manually

        # dbg
        print("results/variants/test_sample.vcf", file=sys.stderr)

        # Run the test job.
        sp.check_output([
            "python",
            "-m",
            "snakemake", 
            "results/variants/test_sample.vcf",
            "-F", 
            "-j1",
            "--keep-target-files",
            "--use-conda",
            "--directory",
            workdir,
        ])

        # remove second line (date line) from vcf file
        remove_second_line_from_file(workdir / "results/variants/test_sample.vcf")

        # Check the output byte by byte using cmp.
        # To modify this behavior, you can inherit from common.OutputChecker in here
        # and overwrite the method `compare_files(generated_file, expected_file), 
        # also see common.py.
        common.OutputChecker(data_path, expected_path, workdir).check()
