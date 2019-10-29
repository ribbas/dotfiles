#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

if __name__ == "__main__":

    toc = "## Table of Contents\n\n"
    if len(sys.argv) > 1:
        with open(sys.argv[1]) as md_file:
            cut_off = int(sys.argv[2]) if len(sys.argv) == 3 else 1
            header_num = 0
            for line in md_file:
                if line[0] == "#":
                    if header_num < cut_off:
                        header_num += 1
                    else:
                        header_num += (header_num == cut_off)
                        header = line[:-1].strip("#").strip(" ")
                        toc += f"{(line.count('#') - header_num) * 2 * ' '}- [{header}](#{header.lower().replace(' ', '-')})\n"

            print(toc)
