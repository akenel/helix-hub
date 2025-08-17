// Enhanced FaaF Template Selector - Dynamic Template Selection
// Place this in your Chuck Academy Processor node

const inputData = items[0].json;
const aiResponse = inputData.output || inputData.response || inputData.content || inputData.text;

// Debug: log what we received
console.log('🔍 AI Response received:', aiResponse);
console.log('📊 Input data keys:', Object.keys(inputData));

// 🎯 ENHANCED TEMPLATE SELECTION LOGIC
function selectFaafTemplate(userData) {
  const profile = (userData.profile_text || '').toLowerCase();
  const jobDesc = (userData.job_description || '').toLowerCase();
  const email = (userData.guest_email || userData.email || '').toLowerCase();
  const name = (userData.guest_name || userData.name || '').toLowerCase();
  
  // Detect gender/demographic hints
  const femaleIndicators = ['she', 'her', 'woman', 'female', 'ms.', 'mrs.', 'miss', 'lady'];
  const youngIndicators = ['intern', 'junior', 'entry', 'graduate', 'recent', 'new grad', 'trainee', 'associate'];
  const seniorIndicators = ['ceo', 'cto', 'cfo', 'vp', 'director', 'senior', 'executive', 'manager', 'lead'];
  const transitionIndicators = ['career change', 'transition', 'pivot', 'looking for', 'seeking', 'exploring'];
  
  const isFemale = femaleIndicators.some(indicator => 
    profile.includes(indicator) || jobDesc.includes(indicator) || name.includes(indicator)
  );
  
  const isYoung = youngIndicators.some(indicator => 
    profile.includes(indicator) || jobDesc.includes(indicator)
  );
  
  const isSenior = seniorIndicators.some(indicator => 
    profile.includes(indicator) || jobDesc.includes(indicator)
  );
  
  const isTransitioning = transitionIndicators.some(indicator => 
    profile.includes(indicator) || jobDesc.includes(indicator)
  );
  
  // Template selection logic
  if (isFemale && isSenior) {
    return 'faaf-female-executive';
  } else if (isYoung || (profile.includes('student') || jobDesc.includes('student'))) {
    return 'faaf-young-professional';
  } else if (isTransitioning) {
    return 'faaf-career-transition';
  } else if (isSenior) {
    return 'faaf-female-executive'; // Use executive template for senior roles
  } else {
    return 'chuck-academy'; // Default Chuck Academy
  }
}

// 🎨 ENHANCED CONTENT GENERATION
function generateEnhancedFaaf(userData, templateType, errorDetails) {
  const baseData = {
    // Original user data (always preserved)
    processing_id: userData.processing_id,
    guest_name: userData.guest_name || userData.name,
    guest_email: userData.guest_email || userData.email,
    profile_text: userData.profile_text,
    job_description: userData.job_description,
    prompt_type: userData.prompt_type,
    timestamp: userData.timestamp,
    oracle_loaded: userData.oracle_loaded || false,
    
    // Enhanced metadata
    content_type: "faaf_enhanced",
    template_type: templateType,
    generation_timestamp: new Date().toISOString(),
    academy_session: Math.floor(Math.random() * 1000) + 1,
    content_quality: "personalized"
  };
  
  // Template-specific content generation
  switch(templateType) {
    case 'faaf-female-executive':
      return {
        ...baseData,
        executive_wisdom: "The glass ceiling doesn't stand a chance against your determination and skill set!",
        executive_advice: "💡 Executive Wisdom: The best leaders turn technical challenges into strategic advantages. Your composure during unexpected situations is exactly what boardrooms need.",
        career_suggestions: ['Chief Executive Officer', 'Chief Operating Officer', 'Chief Strategy Officer', 'Managing Director', 'Board Member', 'Executive Consultant'],
        executive_resources: [
          {title: "🎯 Harvard Business Review Leadership", url: "https://hbr.org/topic/leadership"},
          {title: "💼 McKinsey Leadership Insights", url: "https://www.mckinsey.com/featured-insights/leadership"},
          {title: "🚀 LinkedIn Learning Leadership", url: "https://www.linkedin.com/learning/topics/leadership"}
        ],
        encouragement: `Technology may have stumbled today, but true leaders like ${userData.guest_name || 'you'} turn every challenge into a strategic advantage. Your executive presence and decision-making skills are exactly what the boardroom needs.`,
        user_image: '/static/images/profiles/executive_woman_default.png'
      };
      
    case 'faaf-young-professional':
      return {
        ...baseData,
        young_professional_wisdom: "Every expert was once a beginner. Every pro was once an amateur. Every icon was once an unknown!",
        career_advice: "💡 Young Professional Wisdom: The best professionals learn to roll with the punches. When technology fails, your adaptability shines even brighter!",
        career_suggestions: ['Junior Analyst', 'Associate Consultant', 'Project Coordinator', 'Business Development', 'Account Manager', 'Operations Specialist'],
        young_pro_resources: [
          {title: "🎓 LinkedIn Learning Career Courses", url: "https://www.linkedin.com/learning/"},
          {title: "📚 Coursera Business Skills", url: "https://www.coursera.org/browse/business"},
          {title: "💼 Glassdoor Career Advice", url: "https://www.glassdoor.com/blog/career-advice/"}
        ],
        encouragement: `Hey there, future leader! Technology hiccups happen to everyone, but your ability to stay positive sets you apart. Your career adventure is just getting started, ${userData.guest_name || 'superstar'}!`,
        experience_level: 'Early Career',
        user_image: '/static/images/profiles/young_professional_default.png'
      };
      
    case 'faaf-career-transition':
      return {
        ...baseData,
        transition_wisdom: "The best time to plant a tree was 20 years ago. The second best time is now. Your career transition starts today!",
        transition_advice: "💡 Transition Wisdom: Career changes are like learning to ride a bike - wobbly at first, but then you wonder why you waited so long!",
        career_suggestions: ['Project Manager', 'Business Analyst', 'Operations Manager', 'Customer Success', 'Training Specialist', 'Consultant'],
        transition_resources: [
          {title: "🎯 Indeed Career Change Guide", url: "https://www.indeed.com/career-advice/finding-a-job/how-to-change-careers"},
          {title: "📚 LinkedIn Learning Career Change", url: "https://www.linkedin.com/learning/topics/career-change"},
          {title: "💼 The Muse Career Change Advice", url: "https://www.themuse.com/advice/career-change"}
        ],
        encouragement: `Career transitions take courage, and you've already shown you have that, ${userData.guest_name || 'career changer'}! Today's tech hiccup? Just another example of how you handle challenges.`,
        transition_stage: 'Exploring New Opportunities',
        situation_analysis: "You're in the middle of a career transition - one of the most exciting times in any professional's life!",
        user_image: '/static/images/profiles/career_transition_default.png'
      };
      
    default: // Chuck Academy
      return generateOriginalChuckAcademy(userData, errorDetails);
  }
}

// 🎪 ORIGINAL CHUCK ACADEMY (preserved for backwards compatibility)
function generateOriginalChuckAcademy(userData, errorDetails) {
  const chuckJokes = [
    "Chuck Norris doesn't need a resume. Jobs apply to him.",
    "When Chuck Norris updates his LinkedIn, the servers thank him.",
    "Chuck Norris once got a job by staring at the application form.",
    "The only networking Chuck Norris needs is a roundhouse kick."
  ];
  
  const careerAdvice = [
    "🎯 Pro Tip: Even when AI fails, YOU don't have to. Keep pushing forward!",
    "💡 Career Wisdom: The best professionals adapt when technology doesn't work.",
    "🚀 Success Secret: Turn every setback into a comeback story."
  ];
  
  return {
    ...userData,
    episode_title: `🎪 Chuck Norris Academy: ${userData.guest_name || 'Career Warrior'}'s Adventure`,
    guest_bio: `Meet ${userData.guest_name || 'our guest'}, about to get legendary career advice!`,
    chuck_joke: chuckJokes[Math.floor(Math.random() * chuckJokes.length)],
    chuck_advice: careerAdvice[Math.floor(Math.random() * careerAdvice.length)],
    content_type: "chuck_academy",
    user_image: '/static/images/profiles/chuck_norris_default.png'
  };
}

// 🎯 MAIN PROCESSING LOGIC
if (!aiResponse || aiResponse.trim() === '') {
  console.log('🎪 Triggering Enhanced FaaF: No AI response');
  const selectedTemplate = selectFaafTemplate(inputData);
  console.log(`📋 Selected template: ${selectedTemplate}`);
  
  return [{
    json: generateEnhancedFaaf(inputData, selectedTemplate, "AI didn't respond - but that's okay, we've got this covered!")
  }];
}

// Try to parse AI response (existing logic)
try {
  let cleanedResponse = aiResponse ? aiResponse.trim() : '';
  cleanedResponse = cleanedResponse.replace(/```json\n?/g, '').replace(/```\n?/g, '');
  
  if (cleanedResponse.toLowerCase().includes('slack') || 
      cleanedResponse.toLowerCase().includes('webhook') ||
      cleanedResponse.length > 2000) {
    console.log('🎪 Triggering Enhanced FaaF: AI returned garbage');
    const selectedTemplate = selectFaafTemplate(inputData);
    return [{
      json: generateEnhancedFaaf(inputData, selectedTemplate, "AI got confused - time for personalized wisdom!")
    }];
  }
  
  const jsonStart = cleanedResponse.indexOf('{');
  const jsonEnd = cleanedResponse.lastIndexOf('}') + 1;
  
  if (jsonStart >= 0 && jsonEnd > jsonStart) {
    cleanedResponse = cleanedResponse.substring(jsonStart, jsonEnd);
    const aiContent = JSON.parse(cleanedResponse);
    
    if (aiContent.episode_title && aiContent.guest_bio) {
      console.log('✅ AI Success: Professional content generated');
      return [{ 
        json: {
          ...inputData,
          ...aiContent,
          content_type: "professional",
          ai_model: "llama3.2:1b",
          generation_timestamp: new Date().toISOString()
        }
      }];
    }
  }
  
  throw new Error('Invalid AI content structure');
  
} catch (error) {
  console.log('🎪 Triggering Enhanced FaaF: JSON parsing failed -', error.message);
  const selectedTemplate = selectFaafTemplate(inputData);
  console.log(`📋 Selected template: ${selectedTemplate}`);
  
  return [{
    json: generateEnhancedFaaf(inputData, selectedTemplate, `JSON parsing failed: ${error.message} - but we turned it into something better!`)
  }];
}
