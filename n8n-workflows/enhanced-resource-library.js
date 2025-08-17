// Enhanced Resource Libraries for FaaF Templates
// Add this to your enhanced-faaf-processor.js

const CAREER_RESOURCES = {
  female_executive: [
    {title: "🎯 Harvard Business Review Women in Leadership", url: "https://hbr.org/topic/women-in-leadership"},
    {title: "💼 McKinsey Women in the Workplace", url: "https://www.mckinsey.com/featured-insights/diversity-and-inclusion/women-in-the-workplace"},
    {title: "🚀 Catalyst Women Leadership Research", url: "https://www.catalyst.org/research/"},
    {title: "⭐ Lean In Leadership Development", url: "https://leanin.org/education"},
    {title: "🌟 Chief Executive Network", url: "https://chief.com/"},
    {title: "💡 Fortune Most Powerful Women", url: "https://fortune.com/section/most-powerful-women/"},
    {title: "🎓 Stanford Women's Leadership Program", url: "https://www.stanford.edu/"},
    {title: "💪 Women in Leadership Institute", url: "https://www.womenleadershipinstitute.org/"},
    {title: "🔥 Forbes Women Leadership", url: "https://www.forbes.com/women/"},
    {title: "🎯 Executive Women International", url: "https://executivewomen.org/"},
    {title: "💼 Center for Women in Business", url: "https://www.centerforwomeninbusiness.org/"}
  ],
  
  young_professional: [
    {title: "🎓 LinkedIn Learning for Students", url: "https://www.linkedin.com/learning/students"},
    {title: "📚 Coursera Professional Certificates", url: "https://www.coursera.org/professional-certificates"},
    {title: "💼 Indeed Career Guide for New Grads", url: "https://www.indeed.com/career-advice/starting-new-job"},
    {title: "🚀 Google Career Certificates", url: "https://grow.google/certificates/"},
    {title: "⭐ Glassdoor Entry Level Jobs", url: "https://www.glassdoor.com/Jobs/entry-level-jobs-SRCH_KO0,11.htm"},
    {title: "💡 The Muse Entry Level Career Advice", url: "https://www.themuse.com/advice/entry-level"},
    {title: "🎯 Monster College Resources", url: "https://www.monster.com/career-advice/student"},
    {title: "🌟 CareerBuilder New Graduate Guide", url: "https://www.careerbuilder.com/advice/new-graduate"},
    {title: "📱 Handshake Career Network", url: "https://joinhandshake.com/"},
    {title: "🔥 Fast Company Young Professional Tips", url: "https://www.fastcompany.com/section/career"},
    {title: "💪 Vault Career Intelligence", url: "https://www.vault.com/"}
  ],
  
  career_transition: [
    {title: "🎯 Indeed Career Change Complete Guide", url: "https://www.indeed.com/career-advice/finding-a-job/how-to-change-careers"},
    {title: "📚 LinkedIn Learning Career Change Courses", url: "https://www.linkedin.com/learning/topics/career-change"},
    {title: "💼 The Muse Career Pivot Resources", url: "https://www.themuse.com/advice/career-change"},
    {title: "🚀 Coursera Career Change Programs", url: "https://www.coursera.org/browse/personal-development"},
    {title: "⭐ Harvard Business Review Career Transitions", url: "https://hbr.org/topic/career-transitions"},
    {title: "💡 Monster Career Change Center", url: "https://www.monster.com/career-advice/career-change"},
    {title: "🎓 Udemy Career Development Courses", url: "https://www.udemy.com/topic/career-development/"},
    {title: "🌟 CareerBuilder Career Change Advice", url: "https://www.careerbuilder.com/advice/career-change"},
    {title: "🔥 Forbes Career Transition Articles", url: "https://www.forbes.com/sites/nextavenue/"},
    {title: "💪 AARP Career Change Resources", url: "https://www.aarp.org/work/"},
    {title: "🎯 Career Change Network", url: "https://www.career-change-network.com/"}
  ],
  
  tech_professional: [
    {title: "💻 Stack Overflow Developer Survey", url: "https://survey.stackoverflow.co/"},
    {title: "🚀 GitHub Skills", url: "https://skills.github.com/"},
    {title: "⭐ freeCodeCamp", url: "https://www.freecodecamp.org/"},
    {title: "🎓 Pluralsight Tech Skills", url: "https://www.pluralsight.com/"},
    {title: "💡 Codecademy Career Paths", url: "https://www.codecademy.com/"},
    {title: "🔥 TechCrunch Startup News", url: "https://techcrunch.com/"},
    {title: "🌟 Hacker News", url: "https://news.ycombinator.com/"},
    {title: "💼 AngelList Tech Jobs", url: "https://angel.co/jobs"},
    {title: "🎯 Dev.to Community", url: "https://dev.to/"},
    {title: "📚 O'Reilly Learning Platform", url: "https://www.oreilly.com/"},
    {title: "💪 AWS Training and Certification", url: "https://aws.amazon.com/training/"}
  ],
  
  finance_professional: [
    {title: "💰 CFA Institute Resources", url: "https://www.cfainstitute.org/"},
    {title: "📈 Financial Planning Association", url: "https://www.onefpa.org/"},
    {title: "🏦 American Bankers Association", url: "https://www.aba.com/"},
    {title: "⭐ Bloomberg Financial Training", url: "https://www.bloomberg.com/professional/"},
    {title: "💼 Wall Street Prep", url: "https://www.wallstreetprep.com/"},
    {title: "🎓 Wharton Finance Courses", url: "https://www.wharton.upenn.edu/"},
    {title: "🚀 Financial Modeling Institute", url: "https://www.fminstitute.com/"},
    {title: "💡 Investopedia Financial Education", url: "https://www.investopedia.com/"},
    {title: "🔥 Morningstar Investment Research", url: "https://www.morningstar.com/"},
    {title: "🌟 CPA.com Resources", url: "https://www.cpa.com/"},
    {title: "🎯 Financial Times Learning", url: "https://www.ft.com/"}
  ]
};

const MOTIVATIONAL_QUOTES = {
  female_executive: [
    "The glass ceiling doesn't stand a chance against your determination and skill set!",
    "Leadership isn't about being perfect; it's about being authentic and inspiring others to greatness.",
    "Every boardroom needs your unique perspective and strategic thinking.",
    "You don't just break barriers; you build bridges for the next generation of leaders."
  ],
  
  young_professional: [
    "Every expert was once a beginner. Every pro was once an amateur. Every icon was once an unknown!",
    "Your career is a marathon, not a sprint. Every step forward is progress!",
    "The best time to start building your dream career is right now!",
    "Your fresh perspective and digital-native thinking are exactly what companies need!"
  ],
  
  career_transition: [
    "The best time to plant a tree was 20 years ago. The second best time is now!",
    "Career changes aren't detours; they're strategic pivots toward your true potential.",
    "Your diverse experience makes you uniquely valuable in today's evolving job market.",
    "Every successful professional has reinvented themselves at least once. Your turn!"
  ]
};

// Export for use in templates
module.exports = { CAREER_RESOURCES, MOTIVATIONAL_QUOTES };
