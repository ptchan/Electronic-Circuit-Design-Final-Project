************* Low Voltage Bandgap reference
.lib "/home/raid7_4/raid1_1/cic/vlsi/cic18/model/cic018.l" tt
.temp 40
.param vddvar=1

.option post=3
.option accurate method=gear

.subckt op_amp1 in1 in2 out vdd vss

MMa v1 v3 vdd vdd p_18 w=75u l=0.18u m=1
MMb v2 v3 vdd vdd p_18 w=75u l=0.18u m=1
MMc v5 v1 vdd vdd p_18 w=75u l=0.18u m=1
MMd out v2 vdd vdd p_18 w=75u l=0.18u m=1
MMe v5 v5 vss vss n_18 w=75u l=0.18u m=1
MMf out v5 vss vss n_18 w=75u l=0.18u m=1
MMX v1 in1 v7 v7 n_18 w=75u l=0.18u m=1
MMY v2 in2 v7 v7 n_18 w=75u l=0.18u m=1
Ra v1 v3 40K
Rb v2 v3 40K
Iref v7 vss 50u

.ends


.subckt op_amp2 in1 in2 out vdd vss

MMa v1 v3 vdd vdd p_18 w=2.5u l=0.3u m=1
MMb v2 v3 vdd vdd p_18 w=2.5u l=0.3u m=1
MMc v5 v3 vdd vdd p_18 w=2.5u l=0.3u m=1
MMd out v3 vdd vdd p_18 w=2.5u l=0.3u m=1
MMe v5 v5 vss vss n_18 w=2.5u l=0.3u m=1
MMf out v5 vss vss n_18 w=2.5u l=0.3u m=1
MMX v1 in1 v7 v7 n_18 w=2.5u l=0.3u m=1
MMY v2 in2 v7 v7 n_18 w=2.5u l=0.3u m=1
Ra v1 v3 40K
Rb v2 v3 40K
Iref v7 vss 50u

.ends

.subckt op_amp_prime in1 in2 out vdd vss

MMa out vA vdd vdd p_18 w=100u l=0.32u m=1
MMb vA vA vdd vdd p_18 w=100u l=0.32u m=1
MMx out in1 v1 v1 n_18 w=100u l=0.32u m=1
MMy vA in2 v1 v1 n_18 w=100u l=0.32u m=1
Iref v1 vss 450u

.ends

Vdd DVDD    0   '1.5*vddvar' ac 1
Vss GND    0   0


MM1 vx vp DVDD DVDD p_18 w=100u l=0.32u m=1
MM2 vy vp DVDD DVDD p_18 w=100u l=0.32u m=1
MM3 vn vp DVDD DVDD p_18 w=100u l=0.32u m=1
MM4 vout vA vn DVDD p_18 w=100u l=0.32u m=1
R1 vy vz 2k
R2 vx GND 13k
R3 vy GND 13k
RL vout GND 4.8k
QQ1 GND GND vx PNP_V50X50 l=1u w=10u m=4
QQ2 GND GND vz PNP_V50X50 l=1u w=10u m=67

*MM3 vout vp DVDD DVDD p_18 w=5u l=0.3u m=1

xtwo_stage_ampA1 vx vy vp DVDD GND op_amp1
xtwo_stage_ampA2 vn vy vA DVDD GND op_amp1

*R4 vl vout 5.5k
*c1 vout GND 1p
*c2 vl GND 1p

.ac dec 101 1k 100g
.probe vdb(vout)
.tran 1p 50n

*.meas tran voutavg avg v(out) from=10n
.dc temp 0 100 1

.alter
.lib "/home/raid7_4/raid1_1/cic/vlsi/cic18/model/cic018.l" ff
*.temp 0
.param vddvar=1.1

.alter
.lib "/home/raid7_4/raid1_1/cic/vlsi/cic18/model/cic018.l" ss
*.temp 100
.param vddvar=0.9

.end
