#!/bin/bash
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
new_password=$(shuf pass | tr -d '\n' | shuf | head -c 12)

# Step 2: Output the new password (optional, remove if not needed)
echo "New password: $new_password"

# Step 3: Change the password for the current user using sudo
echo -e "$new_password\n$new_password" | sudo passwd $(whoami)

# Step 4: Confirm success
echo "Password changed successfully."
rm pass

