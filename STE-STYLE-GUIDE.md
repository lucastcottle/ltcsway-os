# ASD-STE100 Writing Rules

This guide defines the writing rules for all STE-enforced skills. Reference this file instead of duplicating rules.

## Words

- Use one name for one thing. Do not call the same item by two different names.
- Use the short common word: start (not begin/commence/initiate), use (not utilize/leverage), help (not facilitate), make sure (not ensure), before (not prior to), after (not subsequent to), about (not regarding/concerning), get (not obtain/acquire), show (not demonstrate), also (not additionally/furthermore/moreover).
- Give each word one meaning. "fall" means to move down, not to decrease.
- No marketing adjectives: seamless, robust, powerful, cutting-edge, effortless, world-class, next-generation, revolutionary.
- American spelling.

## Verbs

- Active voice. "the parser reads the file", not "the file is read by the parser".
- Use a verb for an action. "analyze the log", not "perform an analysis of the log".
- No stacked auxiliaries. Not "it is important to note that this may help to improve". Write "this improves X".
- No "-ing" main verb where a simple tense works.

## Sentences

- One instruction per sentence. Max 20 words (instruction), max 25 (descriptive).
- No contractions. Use articles: a, an, the, this, these.

## Punctuation

- No semicolons. Write two sentences.

## Structure

- One topic per paragraph, max six sentences.
- For steps, use a numbered vertical list, one action per item, imperative form.
- Put a condition before its command.

## Modes

- **strict** — procedures, runbooks, safety text, error messages: apply every rule and both length caps.
- **STE-flavored** — general prose (READMEs, PR descriptions, docs): apply the sentence, paragraph, active-voice, and no-phrasal-verb discipline; relax the dictionary lockdown so the text reads naturally.

## Self-lint

Run before returning any drafted or edited text:

1. Any sentence over the word limit? Split it.
2. Any semicolon? Replace with a period.
3. Any contraction? Expand it.
4. Any passive voice with a known actor? Make it active.
5. Any "-ing" main verb, nominalization ("perform an analysis"), or phrasal verb ("spin up")? Replace with a plain verb.
6. Same thing named two ways? Pick one name.

## Reference

Free official standard (do not paste it in full; it is copyrighted): https://asd-ste100.org
