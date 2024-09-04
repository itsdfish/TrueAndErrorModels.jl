# Model Overview

One challenge in evaluating theories of decision making is that data likely reflex a mixture of true preferences and response error. Suppose a person selects risky option $r$ over safe option $s$. Due to random error, a person may truely prefer $r$ to $s$ and report his or her preferences accurately, or may truely $s$, but respond $r$ by accident.  True and Error Theory (TET;) provides a mathematical framework for distinguishing true preferences from errors in reporting due to various sources, such as trembling hand, failures of memory and/or reasoning, and lapses of attention. 

# Task

The decision making task involves choosing between two sets of options. Each set contains a risky option ``R = (x_{r,1}, p_{r,1}; \dots; x_{r,n}, p_{r,n})`` and a relatively safe option ``S = (x_{s,1}, p_{s,1}; \dots; x_{s,n}, p_{s,n})``. Subjects decide between options for each set twice in one session, and there are two sessions. The joint response set contains 16 patterns: ``\{(R_1R_2,R_1R_2),(R_1R_2,R_1S_2), \dots, (S_1S_2,S_1S_2)\}``.

# True and Error Theory

True and Error Theory (TET; ) provides a mathematical framework for distinguishing true preferences from errors in reporting errors due to various sources, such as trembling hand, failures of memory and/or reasoning, and lapses of attention. 

## Parameters

The full TET model contains 8 parameters in total. The four preference state parameters correspond to the joint the probability of prefering the various combinations of risky and safe options of the two choice sets:

- ``p_{\mathrm{rr}}``: the probability of prefering the risky option in both choice sets
- ``p_{\mathrm{rs}}``: the probability of prefering the risky option in the first choice set and prefering the safe option in the second choice set
- ``p_{\mathrm{sr}}``: the probability of prefering the safe option in the first choice set and prefering the risky option in the second choice set
- ``p_{\mathrm{ss}}``: the probability of prefering the safe option in both choice sets

subject to the constraint that ``p_{\mathrm{rr}} + p_{\mathrm{rs}} + p_{\mathrm{sr}} + p_{\mathrm{ss}} = 1``.

The remaining four parameters correspond to error probabilities. 

- ``\epsilon_{\mathrm{rs}_1}``: the probability of selecting $S_1$ given $R_1$ is prefered.
- ``\epsilon_{\mathrm{rs}_2}``: the probability of selecting $R_2$ given $S_2$ is prefered.
- ``\epsilon_{\mathrm{sr}_1}``: the probability of selecting $S_1$ given $R_1$ is prefered.
- ``\epsilon_{\mathrm{sr}_2}``: the probability of selecting $S_2$ given $R_2$ is prefered.

## Structure
The TET model is structured as a multinomial processing tree in which nodes correspond to cognitive states or processes, and branches correspond to transition probabilities. 

### RR,RR
``
\theta_1 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2}
``
### RR,RS
``
\theta_2 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
### RR,SR
``
\theta_3 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2}
``
### RR,SS
``
\theta_4 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
### RS,RR
``
\theta_5 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2}
``
### RS,RS
``
\theta_6 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
### RS,SR
``
\theta_7 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2}
``
### RS,SS
``
\theta_8 =
    p_{\mathrm{rr}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
### SR,RR
``
\theta_9 =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2}
``
### SR,RS
``
\theta_{10} =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
### SR,SR
``
\theta_{11} =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2}
``
### SR,SS
``
\theta_{12} =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
### SS,RR
``
\theta_{13} =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{sr}_2}
``
### SS,RS
``
\theta_{14} =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{rs}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{sr}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{sr}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
### SS,SR
``
\theta_{15} =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{sr}_2} + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{rs}_2}) + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{sr}_2}
``
### SS,SS
``
\theta_{16} =
    p_{\mathrm{rr}} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} \cdot \epsilon_{\mathrm{rs}_1} \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{rs}} \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot \epsilon_{\mathrm{rs}_1} \cdot (1 - \epsilon_{\mathrm{sr}_2}) + \\ 
    p_{\mathrm{sr}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot \epsilon_{\mathrm{rs}_2} + \\ 
    p_{\mathrm{ss}} \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2}) \cdot (1 - \epsilon_{\mathrm{sr}_1}) \cdot (1 - \epsilon_{\mathrm{sr}_2})
``
