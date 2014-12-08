ReBurner
========

Burn Data to the Bitcoin blockchain without lossing your coins.

The idea and implomintation of "Burning" data to a Crypto Currencies' Blockchain is not new.
However current methods only offer a one-way trip for those coins being Burned; hence the name.

This method makes use of a hack that has show the ability to reviel Bitcoin privet keys from bad signatures and multi signatures to maintain control of your Bitcoins throutout the burning process.
See the Docs directory and numerus comments within each function and script file to gain some understanding of how this all works.

Currently this script is not ready for use and SHOUD NOT be used.
That being stated you can try to run this scipt by declaring a file that has already been compressed and encrypted.
[CODE='how to run reburner.sh']
user@host ~: sh reburner.sh file.tar.enc
[/CODE]
You can generate a file to be parced by this script with the following command
[CODE]
tar c $userInput_selectedFile | opensssl enc -aes-256-cbc -e > BTCkeys_privetHex.tar.enc
[/CODE]

Short discription of your datas' life cycle in this script;
 * first your file is converted into a string of hexedicimal formated integers, bit by bit
 * this long hex string is then [i]choped[/i] into smaller chunkes and a header and footer is placed and calculated for each
 * these converted hex strings are further changed, into base 58 the Bitcoin way, such that they can be imported into non-wiping wallet apps.
Plans for the future;
 * write a webapp (likely in NoFlo) that can preform the same function without a Bash shell
 * write compainion scripts for un-reburning data from the blockchain back into original compressed and encrypted format
 * re-write above for multi-signature wallet address generatation such that 5 keys are required to preform any withdraw; key 1 & 5 generate random signatures and 2-3 generate non-random signatures so that those are the only addresses to have thier privet keys revield. Then for longer files keys 1 & 5 are used on every sequence of "payload-keys"
 * after extencive testing I'll then remove the warninings in the readme and chainge the build state to passing.
Licencing info;
	Much of the content of these scripts was put togeather helpfull individuals that shaired thier knowlage freely.
	I will do the same with these scripts; you may use them as you will, mod them as you wish. I only ask that you use github's fork options such that if your edits are good they can be murged back here for everyone to benofit.
Reliece info;
	12/07/2014 :-: first reliece to the general public of reburner project.
		Build State :-: failing and untested and not sutable for use!!!
		Build version :-: pre-Alpha_0.0.0.1_reburner
		Maintainers :-: S0AndS0, ...
		Notes :-: might work, but more than likely will error out. no adavnced options or user prompts. Just a quick and dirty version of what is to come.
		Warnings :-: do to the untested nature of this wallet generation method DO NOT deposit coins into these addressed being generated!
			Furthermore, if it does work and data can be retrieved from the Blockchain this way, the current version of this script would allow others to take your coins!
			Look for a passing build state or "test net" version so you don't lose your coins!!!


Note the bellow reffarances are there to catch every reader up on the basics of how these exploits and other tools are used.
They (the refferances) will beguin and end with; [SPOILER='<Tital>'][QUOTE='<ReferanceLink>'] <a quoted bit of text> [/QUOTE][/SPOILER] such that original authors are always credited

[SPOILER=''][QUOTE='https://en.m.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm']
Signature generation algorithm

Suppose Alice wants to send a signed message to Bob. Initially, they must agree on the curve parameters (\textrm{CURVE}, G, n). In addition to the field and equation of the curve, we need G, a base point of prime order on the curve; n is the multiplicative order of the point G.
Parameter 	
CURVE 	the elliptic curve field and equation used
G 	elliptic curve base point, a generator of the elliptic curve with large prime order n
n 	integer order of G, means that n \times G = O

Alice creates a key pair, consisting of a private key integer d_A, randomly selected in the interval [1, n-1]; and a public key curve point Q_A = d_A \times G. 
We use \times to denote elliptic curve point multiplication by a scalar.

For Alice to sign a message m, she follows these steps:

    Calculate e = \textrm{HASH}(m), where HASH is a cryptographic hash function, such as SHA-2.
    Let z be the L_n leftmost bits of e, where L_n is the bit length of the group order n.
    Select a random integer k from [1, n-1].
    Calculate the curve point (x_1, y_1) = k \times G.
    Calculate r = x_1\,\bmod\,n. If r = 0, go back to step 3.
    Calculate s = k^{-1}(z + r d_A)\,\bmod\,n. If s = 0, go back to step 3.
    The signature is the pair (r, s).

When computing s, the string z resulting from \textrm{HASH}(m) shall be converted to an integer. Note that z can be greater than n but not longer.[1]

As the standard notes, it is crucial to select different k for different signatures, otherwise the equation in step 6 can be solved for d_A, the private key: 
	Given two signatures (r, s) and (r, s'), employing the same unknown k for different known messages m and m', an attacker can calculate z and z', and since s - s' = k^{-1}(z - z') (all operations in this paragraph are done modulo n) the attacker can find k = \frac{z - z'}{s - s'}. 
	Since s = k^{-1}(z + r d_A), the attacker can now calculate the private key d_A = \frac{s k - z}{r}. 
	This implementation failure was used, for example, to extract the signing key used in the PlayStation 3 gaming-console.[2] 
	Another way ECDSA signature may leak private keys is when k is generated by faulty Random number generator. 
	Such failure of RNG caused users of Android Bitcoin Wallet to lose their funds in August 2013.[3] 
	To ensure that k is unique for each message one may bypass RNG completely and generate deterministic signatures by deriving k from both the message and the private key.[4]
[/QUOTE][/SPOILER]

