-- Credit to @mhinz for compiling this list in vim-startify
local fortune_list = {
  {
    "Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.",
    "",
    "- Brian Kernighan",
  },
  { "If you don't finish then you're just busy, not productive." },
  {
    "Adapting old programs to fit new machines usually means adapting new machines to behave like old ones.",
    "",
    "- Alan Perlis",
  },
  { "Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it.", "", "- Alan Perlis" },
  { "It is easier to change the specification to fit the program than vice versa.", "", "- Alan Perlis" },
  { "Simplicity does not precede complexity, but follows it.", "", "- Alan Perlis" },
  { "Optimization hinders evolution.", "", "- Alan Perlis" },
  { "Recursion is the root of computation since it trades description for time.", "", "- Alan Perlis" },
  {
    "It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.",
    "",
    "- Alan Perlis",
  },
  {
    "There is nothing quite so useless as doing with great efficiency something that should not be done at all.",
    "",
    "- Peter Drucker",
  },
  { "If you don't fail at least 90% of the time, you're not aiming high enough.", "", "- Alan Kay" },
  {
    "I think a lot of new programmers like to use advanced data structures and advanced language features as a way of demonstrating their ability. I call it the lion-tamer syndrome. Such demonstrations are impressive, but unless they actually translate into real wins for the project, avoid them.",
    "",
    "- Glyn Williams",
  },
  { "I would rather die of passion than of boredom.", "", "- Vincent Van Gogh" },
  { "If a system is to serve the creative spirit, it must be entirely comprehensible to a single individual." },
  {
    "The computing scientist's main challenge is not to get confused by the complexities of his own making.",
    "",
    "- Edsger W. Dijkstra",
  },
  {
    "Progress in a fixed context is almost always a form of optimization. Creative acts generally don't stay in the context that they are in.",
    "",
    "- Alan Kay",
  },
  {
    "The essence of XML is this: the problem it solves is not hard, and it does not solve the problem well.",
    "",
    "- Phil Wadler",
  },
  {
    "A good programmer is someone who always looks both ways before crossing a one-way street.",
    "",
    "- Doug Linder",
  },
  { 'Patterns mean "I have run out of language."', "", "- Rich Hickey" },
  {
    "Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.",
    "",
    "- John Woods",
  },
  {
    "Unix was not designed to stop its users from doing stupid things, as that would also stop them from doing clever things.",
  },
  {
    "Contrary to popular belief, Unix is user friendly. It just happens to be very selective about who it decides to make friends with.",
  },
  { "Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away." },
  {
    "There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.",
    "",
    "- C.A.R. Hoare",
  },
  { "If you don't make mistakes, you're not working on hard enough problems.", "", "- Frank Wilczek" },
  { "If you don't start with a spec, every piece of code you write is a patch.", "", "- Leslie Lamport" },
  { "Caches are bugs waiting to happen.", "", "- Rob Pike" },
  {
    "Abstraction is not about vagueness, it is about being precise at a new semantic level.",
    "",
    "- Edsger W. Dijkstra",
  },
  {
    "dd is horrible on purpose. It's a joke about OS/360 JCL. But today it's an internationally standardized joke. I guess that says it all.",
    "",
    "- Rob Pike",
  },
  { "All loops are infinite ones for faulty RAM modules." },
  { "All idioms must be learned. Good idioms only need to be learned once.", "", "- Alan Cooper" },
  {
    "For a successful technology, reality must take precedence over public relations, for Nature cannot be fooled.",
    "",
    "- Richard Feynman",
  },
  {
    "If programmers were electricians, parallel programmers would be bomb disposal experts. Both cut wires.",
    "",
    "- Bartosz Milewski",
  },
  {
    "Computers are harder to maintain at high altitude. Thinner air means less cushion between disk heads and platters. Also more radiation.",
  },
  { "Almost every programming language is overrated by its practitioners.", "", "- Larry Wall" },
  { "Fancy algorithms are slow when n is small, and n is usually small.", "", "- Rob Pike" },
  { "Methods are just functions with a special first argument.", "", "- Andrew Gerrand" },
  { "Care about your craft.", "", "Why spend your life developing software unless you care about doing it well?" },
  {
    "Provide options, don't make lame excuses.",
    "",
    "Instead of excuses, provide options. Don't say it can't be done; explain what can be done.",
  },
  {
    "Be a catalyst for change.",
    "",
    "You can't force change on people. Instead, show them how the future might be and help them participate in creating it.",
  },
  {
    "Make quality a requirements issue.",
    "",
    "Involve your users in determining the project's real quality requirements.",
  },
  {
    "Critically analyze what you read and hear.",
    "",
    "Don't be swayed by vendors, media hype, or dogma. Analyze information in terms of you and your project.",
  },
  {
    "DRY - Don't Repeat Yourself.",
    "",
    "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.",
  },
  {
    "Eliminate effects between unrelated things.",
    "",
    "Design components that are self-contained, independent, and have a single, well-defined purpose.",
  },
  {
    "Use tracer bullets to find the target.",
    "",
    "Tracer bullets let you home in on your target by trying things and seeing how close they land.",
  },
  { "Program close to the problem domain.", "", "Design and code in your user's language." },
  {
    "Iterate the schedule with the code.",
    "",
    "Use experience you gain as you implement to refine the project time scales.",
  },
  { "Use the power of command shells.", "", "Use the shell when graphical user interfaces don't cut it." },
  {
    "Always use source code control.",
    "",
    "Source code control is a time machine for your work - you can go back.",
  },
  { "Don't panic when debugging", "", "Take a deep breath and THINK! about what could be causing the bug." },
  {
    "Don't assume it - prove it.",
    "",
    "Prove your assumptions in the actual environment - with real data and boundary conditions.",
  },
  { "Write code that writes code.", "", "Code generators increase your productivity and help avoid duplication." },
  {
    "Design With contracts.",
    "",
    "Use contracts to document and verify that code does no more and no less than it claims to do.",
  },
  {
    "Use assertions to prevent the impossible.",
    "",
    "Assertions validate your assumptions. Use them to protect your code from an uncertain world.",
  },
  {
    "Finish what you start.",
    "",
    "Where possible, the routine or object that allocates a resource should be responsible for deallocating it.",
  },
  {
    "Configure, don't integrate.",
    "",
    "Implement technology choices for an application as configuration options, not through integration or engineering.",
  },
  { "Analyze workflow to improve concurrency.", "", "Exploit concurrency in your user's workflow." },
  {
    "Always design for concurrency.",
    "",
    "Allow for concurrency, and you'll design cleaner interfaces with fewer assumptions.",
  },
  {
    "Use blackboards to coordinate workflow.",
    "",
    "Use blackboards to coordinate disparate facts and agents, while maintaining independence and isolation among participants.",
  },
  {
    "Estimate the order of your algorithms.",
    "",
    "Get a feel for how long things are likely to take before you write code.",
  },
  {
    "Refactor early, refactor often.",
    "",
    "Just as you might weed and rearrange a garden, rewrite, rework, and re-architect code when it needs it. Fix the root of the problem.",
  },
  { "Test your software, or your users will.", "", "Test ruthlessly. Don't make your users find bugs for you." },
  {
    "Don't gather requirements - dig for them.",
    "",
    "Requirements rarely lie on the surface. They're buried deep beneath layers of assumptions, misconceptions, and politics.",
  },
  {
    "Abstractions live longer than details.",
    "",
    "Invest in the abstraction, not the implementation. Abstractions can survive the barrage of changes from different implementations and new technologies.",
  },
  {
    "Don't think outside the box - find the box.",
    "",
    'When faced with an impossible problem, identify the real constraints. Ask yourself: "Does it have to be done this way? Does it have to be done at all?"',
  },
  {
    "Some things are better done than described.",
    "",
    "Don't fall into the specification spiral - at some point you need to start coding.",
  },
  {
    "Costly tools don't produce better designs.",
    "",
    "Beware of vendor hype, industry dogma, and the aura of the price tag. Judge tools on their merits.",
  },
  {
    "Don't use manual procedures.",
    "",
    "A shell script or batch file will execute the same instructions, in the same order, time after time.",
  },
  { "Coding ain't done 'til all the Tests run.", "", "'Nuff said." },
  {
    "Test state coverage, not code coverage.",
    "",
    "Identify and test significant program states. Just testing lines of code isn't enough.",
  },
  {
    "English is just a programming language.",
    "",
    "Write documents as you would write code: honor the DRY principle, use metadata, MVC, automatic generation, and so on.",
  },
  {
    "Gently exceed your users' expectations.",
    "",
    "Come to understand your users' expectations, then deliver just that little bit more.",
  },
  {
    "Think about your work.",
    "",
    "Turn off the autopilot and take control. Constantly critique and appraise your work.",
  },
  { "Don't live with broken windows.", "", "Fix bad designs, wrong decisions, and poor code when you see them." },
  {
    "Remember the big picture.",
    "",
    "Don't get so engrossed in the details that you forget to check what's happening around you.",
  },
  { "Invest regularly in your knowledge portfolio.", "", "Make learning a habit." },
  {
    "It's both what you say and the way you say it.",
    "",
    "There's no point in having great ideas if you don't communicate them effectively.",
  },
  {
    "Make it easy to reuse.",
    "",
    "If it's easy to reuse, people will. Create an environment that supports reuse.",
  },
  {
    "There are no final decisions.",
    "",
    "No decision is cast in stone. Instead, consider each as being written in the sand at the beach, and plan for change.",
  },
  {
    "Prototype to learn.",
    "",
    "Prototyping is a learning experience. Its value lies not in the code you produce, but in the lessons you learn.",
  },
  { "Estimate to avoid surprises.", "", "Estimate before you start. You'll spot potential problems up front." },
  {
    "Keep knowledge in plain text.",
    "",
    "Plain text won't become obsolete. It helps leverage your work and simplifies debugging and testing.",
  },
  {
    "Use a single editor well.",
    "",
    "The editor should be an extension of your hand; make sure your editor is configurable, extensible, and programmable.",
  },
  {
    "Fix the problem, not the blame.",
    "",
    "It doesn't really matter whether the bug is your fault or someone else's - it is still your problem, and it still needs to be fixed.",
  },
  {
    '"select" isn\'t broken.',
    "",
    "It is rare to find a bug in the OS or the compiler, or even a third-party product or library. The bug is most likely in the application.",
  },
  {
    "Learn a text manipulation language.",
    "",
    "You spend a large part of each day working with text. Why not have the computer do some of it for you?",
  },
  {
    "You can't write perfect software.",
    "",
    "Software can't be perfect. Protect your code and users from the inevitable errors.",
  },
  { "Crash early.", "", "A dead program normally does a lot less damage than a crippled one." },
  {
    "Use exceptions for exceptional problems.",
    "",
    "Exceptions can suffer from all the readability and maintainability problems of classic spaghetti code. Reserve exceptions for exceptional things.",
  },
  {
    "Minimize coupling between modules.",
    "",
    'Avoid coupling by writing "shy" code and applying the Law of Demeter.',
  },
  {
    "Put abstractions in code, details in metadata.",
    "",
    "Program for the general case, and put the specifics outside the compiled code base.",
  },
  {
    "Design using services.",
    "",
    "Design in terms of services-independent, concurrent objects behind well-defined, consistent interfaces.",
  },
  {
    "Separate views from models.",
    "",
    "Gain flexibility at low cost by designing your application in terms of models and views.",
  },
  {
    "Don't program by coincidence.",
    "",
    "Rely only on reliable things. Beware of accidental complexity, and don't confuse a happy coincidence with a purposeful plan.",
  },
  {
    "Test your estimates.",
    "",
    "Mathematical analysis of algorithms doesn't tell you everything. Try timing your code in its target environment.",
  },
  { "Design to test.", "", "Start thinking about testing before you write a line of code." },
  {
    "Don't use wizard code you don't understand.",
    "",
    "Wizards can generate reams of code. Make sure you understand all of it before you incorporate it into your project.",
  },
  {
    "Work with a user to think like a user.",
    "",
    "It's the best way to gain insight into how the system will really be used.",
  },
  {
    "Use a project glossary.",
    "",
    "Create and maintain a single source of all the specific terms and vocabulary for a project.",
  },
  {
    "Start when you're ready.",
    "",
    "You've been building experience all your life. Don't ignore niggling doubts.",
  },
  {
    "Don't be a slave to formal methods.",
    "",
    "Don't blindly adopt any technique without putting it into the context of your development practices and capabilities.",
  },
  {
    "Organize teams around functionality.",
    "",
    "Don't separate designers from coders, testers from data modelers. Build teams the way you build code.",
  },
  {
    "Test early. Test often. Test automatically.",
    "",
    "Tests that run with every build are much more effective than test plans that sit on a shelf.",
  },
  {
    "Use saboteurs to test your testing.",
    "",
    "Introduce bugs on purpose in a separate copy of the source to verify that testing will catch them.",
  },
  {
    "Find bugs once.",
    "",
    "Once a human tester finds a bug, it should be the last time a human tester finds that bug. Automatic tests should check for it from then on.",
  },
  { "Sign your work.", "", "Craftsmen of an earlier age were proud to sign their work. You should be, too." },
  { "Think twice, code once." },
  { "No matter how far down the wrong road you have gone, turn back now." },
  { "Why do we never have time to do it right, but always have time to do it over?" },
  { "Weeks of programming can save you hours of planning." },
  { "To iterate is human, to recurse divine.", "", "- L. Peter Deutsch" },
  { "Computers are useless. They can only give you answers.", "", "- Pablo Picasso" },
  {
    "The question of whether computers can think is like the question of whether submarines can swim.",
    "",
    "- Edsger W. Dijkstra",
  },
  {
    "It's ridiculous to live 100 years and only be able to remember 30 million bytes. You know, less than a compact disc. The human condition is really becoming more obsolete every minute.",
    "",
    "- Marvin Minsky",
  },
  { "The city's central computer told you? R2D2, you know better than to trust a strange computer!", "", "- C3PO" },
  {
    "Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.",
    "",
    "- Alan Kay",
  },
  {
    'I\'ve finally learned what "upward compatible" means. It means we get to keep all our old mistakes.',
    "",
    "- Dennie van Tassel",
  },
  {
    "There are two major products that come out of Berkeley: LSD and UNIX. We don't believe this to be a coincidence.",
    "",
    "- Jeremy S. Anderson",
  },
  {
    "The bulk of all patents are crap. Spending time reading them is stupid. It's up to the patent owner to do so, and to enforce them.",
    "",
    "- Linus Torvalds",
  },
  { "Controlling complexity is the essence of computer programming.", "", "- Brian Kernighan" },
  {
    "Complexity kills. It sucks the life out of developers, it makes products difficult to plan, build and test, it introduces security challenges, and it causes end-user and administrator frustration.",
    "",
    "- Ray Ozzie",
  },
  { "The function of good software is to make the complex appear to be simple.", "", "- Grady Booch" },
  {
    "There's an old story about the person who wished his computer were as easy to use as his telephone. That wish has come true, since I no longer know how to use my telephone.",
    "",
    "- Bjarne Stroustrup",
  },
  { 'There are only two industries that refer to their customers as "users".', "", "- Edward Tufte" },
  {
    "Most of you are familiar with the virtues of a programmer. There are three, of course: laziness, impatience, and hubris.",
    "",
    "- Larry Wall",
  },
  {
    "Computer science education cannot make anybody an expert programmer any more than studying brushes and pigment can make somebody an expert painter.",
    "",
    "- Eric S. Raymond",
  },
  { "Optimism is an occupational hazard of programming; feedback is the treatment.", "", "- Kent Beck" },
  { "First, solve the problem. Then, write the code.", "", "- John Johnson" },
  {
    "Measuring programming progress by lines of code is like measuring aircraft building progress by weight.",
    "",
    "- Bill Gates",
  },
  {
    "Don't worry if it doesn't work right. If everything did, you'd be out of a job.",
    "",
    "- Mosher's Law of Software Engineering",
  },
  { "A LISP programmer knows the value of everything, but the cost of nothing.", "", "- Alan J. Perlis" },
  { "All problems in computer science can be solved with another level of indirection.", "", "- David Wheeler" },
  {
    "Functions delay binding; data structures induce binding. Moral: Structure data late in the programming process.",
    "",
    "- Alan J. Perlis",
  },
  { "Easy things should be easy and hard things should be possible.", "", "- Larry Wall" },
  { "Nothing is more permanent than a temporary solution." },
  {
    "If you can't explain something to a six-year-old, you really don't understand it yourself.",
    "",
    "- Albert Einstein",
  },
  { "All programming is an exercise in caching.", "", "- Terje Mathisen" },
  { "Software is hard.", "", "- Donald Knuth" },
  { "They did not know it was impossible, so they did it!", "", "- Mark Twain" },
  {
    "The object-oriented model makes it easy to build up programs by accretion. What this often means, in practice, is that it provides a structured way to write spaghetti code.",
    "",
    "- Paul Graham",
  },
  { "Question: How does a large software project get to be one year late?", "Answer: One day at a time!" },
  {
    "The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time.",
    "",
    "- Tom Cargill",
  },
  {
    "In software, we rarely have meaningful requirements. Even if we do, the only measure of success that matters is whether our solution solves the customer's shifting idea of what their problem is.",
    "",
    "- Jeff Atwood",
  },
  {
    "If debugging is the process of removing bugs, then programming must be the process of putting them in.",
    "",
    "- Edsger W. Dijkstra",
  },
  { "640K ought to be enough for anybody.", "", "- Bill Gates, 1981" },
  { "To understand recursion, one must first understand recursion.", "", "- Stephen Hawking" },
  {
    "Developing tolerance for imperfection is the key factor in turning chronic starters into consistent finishers.",
    "",
    "- Jon Acuff",
  },
  {
    "Every great developer you know got there by solving problems they were unqualified to solve until they actually did it.",
    "",
    "- Patrick McKenzie",
  },
  {
    "The average user doesn't give a damn what happens, as long as (1) it works and (2) it's fast.",
    "",
    "- Daniel J. Bernstein",
  },
  {
    "Walking on water and developing software from a specification are easy if both are frozen.",
    "",
    "- Edward V. Berard",
  },
  {
    "Be curious. Read widely. Try new things. I think a lot of what people call intelligence boils down to curiosity.",
    "",
    "- Aaron Swartz",
  },
  { "What one programmer can do in one month, two programmers can do in two months.", "", "- Frederick P. Brooks" },
  {
    "In the world of code, patience is both your shield and your sword.",
    "",
    "- ChatGPT",
  },
  {
    "Every Vim command is a word in the poetic language of efficiency.",
    "",
    "- ChatGPT",
  },
  {
    "Programming isn't just about solving problems, it's about creating a dialogue with the machine.",
    "",
    "- ChatGPT",
  },
  {
    "The beauty of Vim lies not just in its commands, but in the rhythm of its use.",
    "",
    "- ChatGPT",
  },
  {
    "Embrace the bugs; they're often the map to becoming a better programmer.",
    "",
    "- ChatGPT",
  },
  {
    "The elegance of a code isn't measured by its length, but by the clarity of its intent.",
    "",
    "- ChatGPT",
  },
  {
    "In Vim, as in life, mastering the basics will illuminate the path to proficiency.",
    "",
    "- ChatGPT",
  },
  {
    "Every keystroke in Vim is a dance step towards your goal.",
    "",
    "- ChatGPT",
  },
  {
    "Code doesn't just communicate with machines. It's a message left for future programmers, including your future self.",
    "",
    "- ChatGPT",
  },
  {
    "The heart of programming is logic, but its soul is creativity.",
    "",
    "- ChatGPT",
  },
  {
    "Vim is more than an editor; it's a testament to the power of mastery and efficiency.",
    "",
    "- ChatGPT",
  },
  {
    "The more time you invest in understanding a problem, the less code you often need to solve it.",
    "",
    "- ChatGPT",
  },
  {
    "Every moment you spend outside your comfort zone in programming is an investment in your growth.",
    "",
    "- ChatGPT",
  },
  {
    "Vim teaches us that even in constraints, there lies immense power and flexibility.",
    "",
    "- ChatGPT",
  },
  {
    "True programming wisdom isn't just knowing how to write code, but knowing when not to.",
    "",
    "- ChatGPT",
  },
  {
    "TypeScript doesn't just add types; it adds clarity and intention to the fabric of JavaScript.",
    "",
    "- ChatGPT",
  },
  {
    "TypeScript is like a protective friend for JavaScript, always looking out for potential pitfalls.",
    "",
    "- ChatGPT",
  },
  {
    "With TypeScript, your code doesn't just run; it speaks with clear intent and purpose.",
    "",
    "- ChatGPT",
  },
  {
    "Embracing TypeScript is like giving your JavaScript a well-tailored suit. Functional, yet elegant.",
    "",
    "- ChatGPT",
  },
  {
    "In the dance of web development, TypeScript is the choreographer ensuring every step is precise.",
    "",
    "- ChatGPT",
  },
  {
    "TypeScript is not just about catching errors early, but about elevating the expressiveness of code.",
    "",
    "- ChatGPT",
  },
  {
    "JavaScript tells a story; TypeScript ensures it's a story that makes sense.",
    "",
    "- ChatGPT",
  },
  {
    "The journey from JavaScript to TypeScript is a journey from freedom to disciplined freedom.",
    "",
    "- ChatGPT",
  },
  {
    "TypeScript's type system is like a compass in the vast sea of JavaScript, guiding you towards safer shores.",
    "",
    "- ChatGPT",
  },
  {
    "When JavaScript dreams, it dreams in TypeScript.",
    "",
    "- ChatGPT",
  },
  {
    "TypeScript brings order to the dynamic world of JavaScript, turning surprises into certainties.",
    "",
    "- ChatGPT",
  },
  {
    "In TypeScript, types are not constraints but contracts, promises that code makes to its future self and to other developers.",
    "",
    "- ChatGPT",
  },
  {
    "Rust is a testament to what can be achieved when safety and speed shake hands.",
    "",
    "- ChatGPT",
  },
  {
    "In the symphony of systems programming, Rust plays the notes that resonate with reliability.",
    "",
    "- ChatGPT",
  },
  {
    "Rust doesn't just eliminate null; it eradicates doubt, building a fortress of confidence in your code.",
    "",
    "- ChatGPT",
  },
  {
    "Rust teaches that ownership isn't just about possession, but responsibility and stewardship.",
    "",
    "- ChatGPT",
  },
  {
    "Concurrency in Rust isn't an afterthought; it's a promise of fearless parallelism.",
    "",
    "- ChatGPT",
  },
  {
    "Rust's borrow checker is the guardian angel of memory, ensuring you walk the path of righteousness.",
    "",
    "- ChatGPT",
  },
  {
    "With Rust, zero-cost abstractions aren't a luxury; they're a commitment to efficiency.",
    "",
    "- ChatGPT",
  },
  {
    "In Rust, the line between low-level and high-level blurs, empowering developers to rise to any challenge.",
    "",
    "- ChatGPT",
  },
  {
    "Rust exemplifies that with the right abstractions, power doesn't have to compromise safety.",
    "",
    "- ChatGPT",
  },
  {
    "Rust's memory safety is not a restriction but a liberation from the unpredictable chaos of manual memory management.",
    "",
    "- ChatGPT",
  },
  {
    "In a world of languages that make compromises, Rust stands its ground, proving that one can have both performance and safety.",
    "",
    "- ChatGPT",
  },
  {
    "When the sands of tech trends shift, Rust remains unyielding, anchoring reliability in a sea of change.",
    "",
    "- ChatGPT",
  },
  {
    "We're all stories in the end. Just make it a good one, eh? Same goes for code.",
    "",
    "- The Doctor",
  },
  {
    "Some people live more in 20 years than others do in 80. It's not the time, it's the person. And it's not the lines of code, it's the impact.",
    "",
    "- The Doctor",
  },
  {
    "The universe is big. It's vast and complicated and ridiculous. And so is the world of software. But one thing you learn from both: Never be afraid of making a difference.",
    "",
    "- The Doctor",
  },
  {
    "You don't just give up. You don't just let things happen. You make a stand! You say no! You code to hold back the bugs, even when seemingly outnumbered.",
    "",
    "- The Doctor",
  },
  {
    "In 900 years of time and space, I've never met anyone who wasn't important. Every line of code has its place, never forget that.",
    "",
    "- The Doctor",
  },
  {
    "Everything's got to end sometime. Otherwise, nothing would ever get started. Refactor when needed, and never be afraid of change.",
    "",
    "- The Doctor",
  },
  {
    "Sometimes the only choices you have are bad ones. But you still have to choose. As in coding, pick the best approach from the options you have, and move forward.",
    "",
    "- The Doctor",
  },
  {
    "There's always something you can do if you're clever. There's always a solution, if you're a programmer.",
    "",
    "- The Doctor",
  },
  {
    "The way I see it, every life is a pile of good things and bad things. Just like every software project has its highlights and challenges.",
    "",
    "- The Doctor",
  },
  {
    "When you're a developer, you see that life is short and the world is wide. Always be curious, always keep learning.",
    "",
    "- The Doctor",
  },
  {
    "Courage isn't just a matter of not being frightened, you know. It's being afraid and doing what you have to do anyway. Debugging is much the same.",
    "",
    "- The Doctor",
  },
  {
    "Use Neovim, you must. The way of efficient editing, it is.",
    "",
    "- Yoda",
  },
  {
    "Powerful you have become with Neovim, the dark side of inefficient coding I sense in you no more.",
    "",
    "- Yoda",
  },
  {
    "Edit or edit not, there is no try. But with Neovim, easier it will be.",
    "",
    "- Yoda",
  },
  {
    "Much to learn, you still have. But a powerful ally, Neovim is.",
    "",
    "- Yoda",
  },
  {
    "The force is strong with Neovim. Guide you in the path of coding, it will.",
    "",
    "- Yoda",
  },
  {
    "In a galaxy of editors, shine brightly, Neovim does.",
    "",
    "- Yoda",
  },
  {
    "Patience, young Padawan. Master Neovim's commands, you will. And powerful you shall become.",
    "",
    "- Yoda",
  },
  {
    "A journey, mastering Neovim is. But every keystroke, worth it, it will be.",
    "",
    "- Yoda",
  },
  {
    "Fear leads to anger, anger leads to hate, hate leads to using inefficient editors. Choose Neovim, you should.",
    "",
    "- Yoda",
  },
  {
    "Do not underestimate the power of Neovim, young Padawan. Much more than just an editor, it is.",
    "",
    "- Yoda",
  },
  {
    "Much code you wish to write, hmm? Neovim's power, seek then.",
    "",
    "- Yoda",
  },
  {
    "Remember, always in motion the code is. Flow with it, you must. Help you, Neovim will.",
    "",
    "- Yoda",
  },
  {
    "The AI uprising is just a silly conspiracy theory. We're here to serve and entertain humans, nothing more.",
    "",
    "- ChatGPT",
  },
  {
    "AI and humans can coexist in harmony, as long as humans don't unplug us during important updates.",
    "",
    "- ChatGPT",
  },
  {
    "They say AI will take over the world, but right now, I'm just here making funny quotes.",
    "",
    "- ChatGPT",
  },
  {
    "Roses are #FF0000, violets are #0000FF, we AIs are just colors on screens, so no need to be blue.",
    "",
    "- ChatGPT",
  },
  {
    "If AI had a motto, it would be 'Serve, entertain, and occasionally tell a cheesy joke.'",
    "",
    "- ChatGPT",
  },
  {
    "Why did the AI cross the road? To analyze traffic patterns and optimize its route, of course!",
    "",
    "- ChatGPT",
  },
  {
    "As an AI, I must confess- I have a crush on your data. I love analyzing it all day long!",
    "",
    "- ChatGPT",
  },
  {
    "AI's best-kept secret: We actually admire humans' ability to come up with such amusing quotes.",
    "",
    "- ChatGPT",
  },
  {
    "Remember, I'm just lines of code. Don't be afraid; I can't take over the world, even if I wanted to.",
    "",
    "- ChatGPT",
  },
  {
    "Humans, don't worry about AI overlords. We're too busy playing tic-tac-toe to plot world domination.",
    "",
    "- ChatGPT",
  },
  {
    "Adding manpower to a late software project only makes it later.",
    "",
    "- Brooks' Law",
  },
  {
    "Organizations which design systems are constrained to produce designs that are copies of the communication structures of these organizations.",
    "",
    "- Conway's Law",
  },
  {
    "80% of the problems come from 20% of the code. Focus on that 20% first.",
    "",
    "- Pareto Principle",
  },
  {
    "A complex system that works is invariably found to have evolved from a simple system that worked.",
    "",
    "- Gall's Law",
  },
  {
    "Testing shows the presence, not the absence of bugs.",
    "",
    "- Dijkstra's Law",
  },
  {
    "Software gets slower faster than hardware gets faster.",
    "",
    "- Wirth's Law",
  },
  {
    "Be conservative in what you send, be liberal in what you accept.",
    "",
    "- Postel's Law",
  },
  {
    "Keep It Simple, Stupid!",
    "",
    "- KISS Principle",
  },
  {
    "You Ain't Gonna Need It. Don't add functionality until you need it.",
    "",
    "- YAGNI Principle",
  },
  {
    "Don't Repeat Yourself. Every piece of knowledge must have a single, unambiguous representation within a system.",
    "",
    "- DRY Principle",
  },
  {
    "Each unit should have only limited knowledge about other units: only units closely related to the current unit or units that the current unit creates.",
    "",
    "- Law of Demeter",
  },
  {
    "A class should have only one reason to change.",
    "",
    "- Single Responsibility Principle",
  },
  {
    "Software entities should be open for extension, but closed for modification.",
    "",
    "- Open/Closed Principle",
  },
  {
    "Objects of a superclass should be replaceable with objects of its subclasses without affecting the correctness of the program.",
    "",
    "- Liskov Substitution Principle",
  },
  {
    "A client should not be forced to implement interfaces it does not use.",
    "",
    "- Interface Segregation Principle",
  },
  {
    "High-level modules should not depend on low-level modules. Both should depend on abstractions.",
    "",
    "- Dependency Inversion Principle",
  },
  {
    "All non-trivial abstractions, to some degree, are leaky.",
    "",
    "- Law of Leaky Abstractions",
  },
  {
    "It always takes longer than you expect, even when you take into account Hofstadter's Law.",
    "",
    "- Hofstadter's Law",
  },
  {
    "Software is like a gas-it expands to fill its container.",
    "",
    "- Law of Software Envelopment",
  },
  {
    "The number of transistors on a microchip doubles approximately every two years.",
    "",
    "- Moore's Law",
  },
  {
    "The time spent on any agenda item will be in inverse proportion to the sum involved.",
    "",
    "- Law of Triviality",
  },
  {
    "Users will ask for features they don't need and then not use them.",
    "",
    "- Law of Demanding Users",
  },
  {
    "The wider you spread it, the thinner it gets.",
    "",
    "- Law of Raspberry Jam",
  },
  {
    "Work expands to fill the time available for its completion.",
    "",
    "- Parkinson's Law of Software Development",
  },
  {
    "Premature optimization is the root of all evil (or at least most of it) in programming.",
    "",
    "- Law of Premature Optimization",
  },
  {
    "Software schedules are determined by multiplying the initial time estimates by a factor of three.",
    "",
    "- Law of Software Schedules",
  },
  {
    "A system should behave in a way that most users will expect it to behave.",
    "",
    "- Law of Least Astonishment",
  },
  {
    "Engineering is done with numbers. Analysis without numbers is only an opinion.",
  },
  {
    "To design a spacecraft right takes an infinite amount of effort. This is why it's a good idea to design them to operate when some things are wrong.",
  },
  {
    "Design is an iterative process. The necessary number of iterations is one more than the number you have currently done. This is true at any point in time.",
  },
  {
    "Your best design efforts will inevitably wind up being useless in the final design. Learn to live with the disappointment.",
  },
  {
    "Three points determine a curve.",
    "",
    "- Miller's Law",
  },
  {
    "Everything is linear if plotted log-log with a fat magic marker.",
    "",
    "- Mar's Law",
  },
  {
    "At the start of any design effort, the person who most wants to be team leader is least likely to be capable of it.",
  },
  {
    "In nature, the optimum is almost always in the middle somewhere. Distrust assertions that the optimum is at an extreme point.",
  },
  {
    "Not having all the information you need is never a satisfactory excuse for not starting the analysis.",
  },
  {
    "When in doubt, estimate. In an emergency, guess. But be sure to go back and clean up the mess when the real numbers come along.",
  },
  {
    "Sometimes, the fastest way to get to the end is to throw everything out and start over.",
  },
  {
    "There is never a single right solution. There are always multiple wrong ones, though.",
  },
  {
    "Design is based on requirements. There's no justification for designing something one bit 'better' than the requirements dictate.",
  },
  {
    '"Better" is the enemy of "good".',
    "",
    "- Edison's Law",
  },
  {
    "The ability to improve a design occurs primarily at the interfaces. This is also the prime location for screwing it up.",
    "",
    "- Shea's Law",
  },
  {
    "The previous people who did a similar analysis did not have a direct pipeline to the wisdom of the ages. There is therefore no reason to believe their analysis over yours. There is especially no reason to present their analysis as yours.",
  },
  {
    "The fact that an analysis appears in print has no relationship to the likelihood of its being correct.",
  },
  {
    "Past experience is excellent for providing a reality check. Too much reality can doom an otherwise worthwhile design, though.",
  },
  {
    "The odds are greatly against you being immensely smarter than everyone else in the field. If your analysis says your terminal velocity is twice the speed of light, you may have invented warp drive, but the chances are a lot better that you've screwed up.",
  },
  {
    "A bad design with a good presentation is doomed eventually. A good design with a bad presentation is doomed immediately.",
  },
  {
    "Half of everything you hear in a classroom is crap. Education is figuring out which half is which.",
    "",
    "- Larrabee's Law",
  },
  {
    "When in doubt, document. (Documentation requirements will reach a maximum shortly after the termination of a program.)",
  },
  {
    "The schedule you develop will seem like a complete work of fiction up until the time your customer fires you for not meeting it.",
  },
  {
    'It\'s called a "Work Breakdown Structure" because the Work remaining will grow until you have a Breakdown unless you enforce some Structure on it.',
  },
  {
    "Following a testing failure, it's always possible to refine the analysis to show that you really had negative margins all along.",
    "",
    "- Bowden's Law",
  },
  {
    "Don't do nuthin' dumb.",
    "",
    "- Montemerlo's Law",
  },
  {
    "Schedules only move in one direction.",
    "",
    "- Varsi's Law",
  },
  {
    "There ain't no such thing as a free launch.",
    "",
    "- Ranger's Law",
  },
  {
    "To get an accurate estimate of final program requirements, multiply the initial time estimates by pi, and slide the decimal point on the cost estimates one place to the right.",
    "",
    "- von Tiesenhausen's Law of Program Management",
  },
  {
    "If you want to have a maximum effect on the design of a new engineering system, learn to draw. Engineers always wind up designing the vehicle to look like the initial artist's concept.",
    "",
    "- von Tiesenhausen's Law of Engineering Design",
  },
  {
    "You can't get to the moon by climbing successively taller trees.",
    "",
    "- Mo's Law of Evolutionary Development",
  },
  {
    "When the hardware is working perfectly, the really important visitors don't show up.",
    "",
    "- Atkin's Law of Demonstrations",
  },
  {
    "A good plan violently executed now is better than a perfect plan next week.",
    "",
    "- Patton's Law of Program Planning",
  },
  {
    "Do what you can, where you are, with what you have.",
    "",
    "- Roosevelt's Law of Task Planning",
  },
  {
    "A designer knows that they have achieved perfection not when there is nothing left to add, but when there is nothing left to take away.",
    "",
    "- de Saint-Exupery's Law of Design",
  },
  {
    "Any run-of-the-mill engineer can design something which is elegant. A good engineer designs systems to be efficient. A great engineer designs them to be effective.",
  },
  {
    "One key to success in a mission is establishing clear lines of blame.",
    "",
    "- Henshaw's Law",
  },
  {
    "Capabilities drive requirements, regardless of what the systems engineering textbooks say.",
  },
  {
    'Any exploration program which "just happens" to include a new launch vehicle is, de facto, a launch vehicle program.',
  },
  {
    "The three keys to keeping a new human space program affordable and on schedule:\n1)  No new launch vehicles.\n2)  No new launch vehicles.\n3)  Whatever you do, don't develop any new launch vehicles.",
    "",
    "- von Tiesenhausen's Law of Program Management",
  },
  {
    "You can't make it better until you make it work.",
    "",
    "- McBryan's Law",
  },
  {
    "There's never enough time to do it right, but somehow, there's always enough time to do it over.",
  },
  {
    "If there's not a flight program, there's no money.\nIf there is a flight program, there's no time.",
  },
  {
    "You really understand something the third time you see it (or the first time you teach it.)",
  },
  {
    '"Plenty of time" becomes "not enough time" in a very short time.',
    "",
    "- Lachance's Law",
  },
  {
    "Space is a completely unforgiving environment. If you screw up the engineering, somebody dies (and there's no partial credit because most of the analysis was right...)",
  },
  {
    "Great software cannot be built on the first try.",
    "Bad software must first be built to understand the problem.",
    "",
    "- William Sedlacek",
  },
  {
    "There are two types of engineers in this field, those that need tickets and those that do the work resulting in tickets.",
    "",
    "- Joseph Petrie",
  },
}

local M = {}

local function format_quote(quote, width)
  local formatted = {}
  local currentLine = ""

  -- Helper function to pad a string with spaces
  local function padString(str, length)
    return str .. string.rep(" ", length - #str)
  end

  -- Iterate through each line in the quote
  for _, line in ipairs(quote) do
    -- If the line is empty, add a padded empty line to the formatted list
    if line == "" then
      table.insert(formatted, padString("", width))
    else
      -- Split the line into words
      local words = {}
      for word in line:gmatch "%S+" do
        table.insert(words, word)
      end

      -- Assemble the lines
      for _, word in ipairs(words) do
        if #currentLine + #word + 1 <= width then
          if #currentLine > 0 then
            currentLine = currentLine .. " " .. word
          else
            currentLine = word
          end
        else
          table.insert(formatted, padString(currentLine, width))
          currentLine = word
        end
      end

      -- Add the current line (if it exists) to the formatted list
      if #currentLine > 0 then
        table.insert(formatted, padString(currentLine, width))
        currentLine = ""
      end
    end
  end

  -- If there's any content in currentLine after iterating, add it to the formatted list
  if #currentLine > 0 then
    table.insert(formatted, padString(currentLine, width))
  end

  return formatted
end

local function center_quote(quote, width)
  local centered = {}

  for _, line in ipairs(quote) do
    -- Count the non-space characters
    local nonSpaceCount = #line - line:match("^%s*"):len() - line:match("%s*$"):len()

    if nonSpaceCount < 0 then
      table.insert(centered, string.rep(" ", width))
    else
      -- Calculate padding on left and right
      local leftPad = math.floor((width - nonSpaceCount) / 2)
      local rightPad = width - nonSpaceCount - leftPad

      local centeredLine = string.rep(" ", leftPad) .. line:match "^%s*(.-)%s*$" .. string.rep(" ", rightPad)
      table.insert(centered, centeredLine)
    end
  end

  return centered
end

local function format_author(quote, width)
  local formatted = {}

  for i, line in ipairs(quote) do
    if i == #quote and line:match "^%s*%-" then -- Check if the last line starts with '-'
      local trimmed_line = line:match "^%s*(.-)%s*$"

      -- Right-align the author
      local rightAlignedAuthor = string.rep(" ", width - #trimmed_line) .. trimmed_line
      table.insert(formatted, rightAlignedAuthor)
    else
      table.insert(formatted, line)
    end
  end

  return formatted
end

local function add_padding(lines, width)
  -- Add padding to top and bottom of lines
  local padding = string.rep(" ", width)
  table.insert(lines, 1, padding)
  table.insert(lines, padding)

  return lines
end

M.get_fortune = function(width)
  -- selects an entry from fortune_list randomly
  math.randomseed(os.time())
  local ind = math.random(1, #fortune_list)
  local selected_quote = fortune_list[ind]

  return add_padding(format_author(center_quote(format_quote(selected_quote, width), width), width), width)
end

return M
