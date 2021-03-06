-- 1.4 Exercise 4
-- Problem statement: find the top 100 users per uploaded bytes.
-- Hint: there are different ways of solving this exercise, in particular, in recent PIG versions there is a function called
-- TOP, that returns the top-n tuples from a bag of tuples (see http://pig.apache.org/docs/r0.11.1/func.html#topx).
-- Questions: 1. Is this job map-only? Why? Why not? 2. Where did you apply the TOP function? 3. Can you explain how
-- does the TOP function work? 4. TOP function was introduced in PIG v.0.8. How, in your opinion, and based on your
-- understanding of PIG, was the query answered before the TOP command was available? Do you think that it was less
-- efficient than the current implementation?

B = GROUP A BY ip_c;
C = FOREACH B GENERATE group, SUM(A.unique_bytes_c);
D = GROUP C ALL; -- devo farlo poichè TOP lavora su campi bag
E = FOREACH D { -- con {} faccio una serie di operazioni
        result = TOP(10, 1, C);
        GENERATE FLATTEN(result); -- result crea 10 bag --> con fltten metto tutto dentro a una singola bag
    };
DUMP E;

