# Model Overview

One challenge in evaluating theories of decision making is that data likely reflect a mixture of true preferences and response error. Suppose a person selects risky option $\mathcal{R}$ over safe option $\mathcal{S}$. This response could arise through two different pathways. First, a person may truely prefer $\mathcal{R}$ to $\mathcal{S}$ and report his or her preferences accurately. Alternatively, this person may truely $\mathcal{S}$, but select $\mathcal{R}$ by accident. True and Error Theory (TET; Birnbaum,  & Quispe-Torreblanca, 2018) provides a mathematical framework for distinguishing true preferences from errors in reporting due to various sources, such as trembling hand, failures of memory and/or reasoning, and lapses of attention. 

# Task

TET can be applied to a wide variety of tasks in which subjects make repeated decisions from the same choice sets. As a simple example, we will consider a decision making task in which subjects choose between two sets of options: 

``\mathcal{C}_1 = \{\mathcal{R}_1,\mathcal{S}_1\}``

and 

 ``\mathcal{C}_2 = \{\mathcal{R}_2,\mathcal{S}_2\}``,

where $\mathcal{R}$ represents a risky gamble and $\mathcal{S}$ represents a safe gamble. In general, a generic gamble $\mathcal{G}$ is defined by the discrete payoff distribution:
 
``\mathcal{G} = (x_{1}, p_{1}; \dots; x_{n}, p_{n}),`` 

where outcome $x_i$ occurs with probability $p_i$. The key difference between gambles $\mathcal{R}$ and $\mathcal{S}$ is that $\mathrm{Var}[\mathcal{R}] > \mathrm{Var}[\mathcal{S}]$. An important requirement for TET is that subjects select an option from both choice sets at least twice within the same session. Assuming two replications each, the resulting joint response set contains 16 patterns: 

``\{(\mathcal{R}_1\mathcal{R}_2,\mathcal{R}_1\mathcal{R}_2),(\mathcal{R}_1\mathcal{R}_2,\mathcal{R}_1\mathcal{S}_2), \dots, (\mathcal{S}_1\mathcal{S}_2,\mathcal{S}_1\mathcal{S}_2)\}``.

# True and Error Theory

As noted above, True and Error Theory provides a mathematical framework for distinguishing true preferences from errors in reporting errors due to various sources, such as trembling hand, failures of memory and/or reasoning, and lapses of attention. According to TET, there are four possible preference states, one for each possible option: RR, RS, SR, SS. For example, preference state SR indicates a person pefers the safe option in the first choice set, and the risky option in the second choice set.

## Parameters

The full TET model contains 8 parameters in total. Four of the parameters represent the joint probability of the four true preference states:

- ``p_{\mathrm{RR}}``: the probability of prefering the risky option in both choice sets
- ``p_{\mathrm{RS}}``: the probability of prefering the risky option in the first choice set and prefering the safe option in the second choice set
- ``p_{\mathrm{SR}}``: the probability of prefering the safe option in the first choice set and prefering the risky option in the second choice set
- ``p_{\mathrm{SS}}``: the probability of prefering the safe option in both choice sets

subject to the constraint that ``p_{\mathrm{RR}} + p_{\mathrm{RS}} + p_{\mathrm{SR}} + p_{\mathrm{SS}} = 1``.

The remaining four parameters correspond to error probabilities. 

- ``\epsilon_{\mathrm{S}_1}``: the error probability of selecting $\mathcal{S}_1$ given that $\mathcal{R}_1$ is prefered.
- ``\epsilon_{\mathrm{S}_2}``: the error probability of selecting $\mathcal{S}_2$ given that $\mathcal{R}_2$ is prefered.
- ``\epsilon_{\mathrm{R}_1}``: the error probability of selecting $\mathcal{R}_1$ given that $\mathcal{S}_1$ is prefered.
- ``\epsilon_{\mathrm{R}_2}``: the error probability of selecting $\mathcal{R}_2$ given that $\mathcal{S}_2$ is prefered.

## Structure

The TET model is structured as a multinomial processing tree in which nodes correspond to cognitive states or processes, and branches correspond to transition probabilities. In total, the TET model has 16 equations, corresponding to the 16 possible response patterns. Each equation is displayed below. As an example, consider the first equation, which corresonds to response pattern $(\mathcal{R}_1\mathcal{R}_2$,$\mathcal{R}_1\mathcal{R}_2)$. Although the risky option was selected for each decision, the TET model proposes that the response pattern could have been generated from any of the four preference states enumerated above. Each possible preference state occurs with a given probability and produces the observed choice pattern with a combination of correct and error responses. As an example, consider the first term in $\theta_1$ in which the assumed preference state is RR:

``p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}).``

Under this assumption, each response is produced by correctly reporting the preference state. Hence, all four terms with $\epsilon_i$ use the complementary probability $1 - \epsilon_i$. Now consider the fourth term in which the assumed preference state is SS: 

``p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2}.``

Under this alternative assumption, all four responses are produced through error. A similar line of reasoning is used to define the remaining equations below.

### $\mathcal{R}_1\mathcal{R}_2$,$\mathcal{R}_1\mathcal{R}_2$
``
\theta_1 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{R}_1\mathcal{R}_2$,$\mathcal{R}_1\mathcal{S}_2$
``
\theta_2 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2})
``
### $\mathcal{R}_1\mathcal{R}_2$,$\mathcal{S}_1\mathcal{R}_2$
``
\theta_3 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{R}_1\mathcal{R}_2$,$\mathcal{S}_1\mathcal{S}_2$
``
\theta_4 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2})
``
### $\mathcal{R}_1\mathcal{S}_2$,$\mathcal{R}_1\mathcal{R}_2$
``
\theta_5 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{R}_1\mathcal{S}_2$,$\mathcal{R}_1\mathcal{S}_2$
``
\theta_6 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2})
``
### $\mathcal{R}_1\mathcal{S}_2$,$\mathcal{S}_1\mathcal{R}_2$
``
\theta_7 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{R}_1\mathcal{S}_2$,$\mathcal{S}_1\mathcal{S}_2$
``
\theta_8 =
    p_{\mathrm{RR}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2})
``
### $\mathcal{S}_1\mathcal{R}_2$,$\mathcal{R}_1\mathcal{R}_2$
``
\theta_9 =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{S}_1\mathcal{R}_2$,$\mathcal{R}_1\mathcal{S}_2$
``
\theta_{10} =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2})
``
### $\mathcal{S}_1\mathcal{R}_2$,$\mathcal{S}_1\mathcal{R}_2$
``
\theta_{11} =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{S}_1\mathcal{R}_2$,$\mathcal{S}_1\mathcal{S}_2$
``
\theta_{12} =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2})
``
### $\mathcal{S}_1\mathcal{S}_2$,$\mathcal{R}_1\mathcal{R}_2$
``
\theta_{13} =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{S}_1\mathcal{S}_2$,$\mathcal{R}_1\mathcal{S}_2$
``
\theta_{14} =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{S}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{R}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{R}_1} \cdot (1 - \epsilon_{\mathrm{R}_2})
``
### $\mathcal{S}_1\mathcal{S}_2$,$\mathcal{S}_1\mathcal{R}_2$
``
\theta_{15} =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{R}_2} + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{S}_2}) + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{R}_2}
``
### $\mathcal{S}_1\mathcal{S}_2$,$\mathcal{S}_1\mathcal{S}_2$
``
\theta_{16} =
    p_{\mathrm{RR}} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} \cdot \epsilon_{\mathrm{S}_1} \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{RS}} \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot \epsilon_{\mathrm{S}_1} \cdot (1 - \epsilon_{\mathrm{R}_2}) + \\ 
    p_{\mathrm{SR}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot \epsilon_{\mathrm{S}_2} + \\ 
    p_{\mathrm{SS}} \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2}) \cdot (1 - \epsilon_{\mathrm{R}_1}) \cdot (1 - \epsilon_{\mathrm{R}_2})
``
# References

Birnbaum, M. H., & Quispe-Torreblanca, E. G. (2018). TEMAP2. R: True and error model analysis program in R. Judgment and Decision Making, 13(5), 428-440.