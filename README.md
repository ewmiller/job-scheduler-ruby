# Job Scheduler in Ruby

## About
This is a job scheduler which uses the FCFS and Round Robin algorithms to process a batch of jobs, simulating the scheduling that operating systems do.
Jobs are described in text files, located in the resources/ directory. The text files are formatted as follows:

100  
600  
11  
2 10  
5 8  
9 1  
15 4  

etc.  


Where the first three lines indicate the number of jobs, the simulation time, and the maximum length of each job, respectively.
Each line after the first three represents one job, and indicates a start time and job length.

Program output is formatted as follows:
[ALGORITHM] [TEXT FILE]: [AVERAGE WAIT TIME]

Thus the purpose of this program is to implement the FCFS and RR algorithms, and compare the two in terms of average wait time.

## Usage

Run `rake` from the Part1 directory. Output is written to `solution.txt`.
