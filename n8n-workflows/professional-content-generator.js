// Professional Content Generator - Hardcoded Professional Templates
// Use this as a Code node replacement for the problematic AI Agent

const userData = items[0].json;

// 🎯 PROFESSIONAL CONTENT TEMPLATES BY TYPE
function generateProfessionalContent(userData) {
  const profile = (userData.profile_text || '').toLowerCase();
  const jobDesc = (userData.job_description || '').toLowerCase();
  const promptType = userData.prompt_type || 'general';
  
  // Detect industry/role patterns
  const isTech = profile.includes('tech') || profile.includes('software') || profile.includes('developer') || profile.includes('engineer');
  const isFinance = profile.includes('finance') || profile.includes('banking') || profile.includes('investment');
  const isMarketing = profile.includes('marketing') || profile.includes('sales') || profile.includes('brand');
  const isExecutive = jobDesc.includes('ceo') || jobDesc.includes('cto') || jobDesc.includes('director') || jobDesc.includes('vp');
  
  // Base professional content
  const baseContent = {
    episode_title: `Professional Spotlight: ${userData.guest_name || 'Industry Leader'}'s Career Journey`,
    guest_bio: `Meet ${userData.guest_name || 'our guest'}, a ${userData.job_description || 'professional'} with expertise in ${userData.profile_text || 'their field'}. Join us as we explore their career insights and industry experience.`,
    professional_bio: `${userData.guest_name || 'Our guest'} brings extensive experience in ${userData.profile_text || 'their field'} as a ${userData.job_description || 'professional'}. Their career demonstrates a commitment to excellence and innovation that has made them a respected voice in the industry.`,
    talking_points: `Key discussion areas include: professional development in ${userData.profile_text || 'the industry'}, leadership lessons from ${userData.job_description || 'their role'}, industry trends and future outlook, career advice for aspiring professionals.`
  };
  
  // Industry-specific customization
  if (isTech) {
    return {
      ...baseContent,
      episode_title: `Tech Innovator Spotlight: ${userData.guest_name || 'Tech Leader'}'s Digital Journey`,
      win_story_1: `Early in their tech career, ${userData.guest_name || 'our guest'} developed innovative solutions that streamlined processes and improved user experience.`,
      win_story_2: `Through strategic technical leadership, they successfully scaled systems and mentored development teams to achieve breakthrough results.`,
      industry_insight: `Based on their experience in ${userData.profile_text || 'technology'}, they've observed the rapid evolution of digital transformation and its impact on business operations.`,
      question_1: `Can you walk us through your journey into ${userData.job_description || 'technology'} and what initially sparked your passion for innovation?`,
      question_2: `What has been your most challenging technical project, and how did you navigate the complexities to achieve success?`,
      question_3: `Looking at the current tech landscape, what emerging technologies do you see as game-changers for businesses?`
    };
  }
  
  if (isFinance) {
    return {
      ...baseContent,
      episode_title: `Financial Leadership Spotlight: ${userData.guest_name || 'Finance Expert'}'s Strategic Journey`,
      win_story_1: `Early in their finance career, ${userData.guest_name || 'our guest'} identified key market opportunities that resulted in significant portfolio growth.`,
      win_story_2: `Through strategic financial planning and risk management, they successfully navigated market volatility and protected stakeholder interests.`,
      industry_insight: `Based on their experience in ${userData.profile_text || 'finance'}, they've observed critical shifts in market dynamics and investment strategies.`,
      question_1: `What drew you to ${userData.job_description || 'finance'} and how has your approach to financial strategy evolved?`,
      question_2: `Can you share a pivotal moment where your financial expertise made a significant impact on business outcomes?`,
      question_3: `What trends in the financial markets should professionals be watching, and how should they prepare?`
    };
  }
  
  if (isMarketing) {
    return {
      ...baseContent,
      episode_title: `Marketing Visionary: ${userData.guest_name || 'Marketing Leader'}'s Brand-Building Journey`,
      win_story_1: `Early in their marketing career, ${userData.guest_name || 'our guest'} launched campaigns that significantly increased brand awareness and customer engagement.`,
      win_story_2: `Through innovative marketing strategies and data-driven insights, they successfully grew market share and built lasting customer relationships.`,
      industry_insight: `Based on their experience in ${userData.profile_text || 'marketing'}, they've witnessed the transformation of customer behavior and digital marketing evolution.`,
      question_1: `How did you get started in ${userData.job_description || 'marketing'} and what drives your passion for brand building?`,
      question_2: `What's been your most successful marketing campaign, and what key lessons did you learn from it?`,
      question_3: `With the rapid changes in digital marketing, what strategies should brands focus on to stay relevant?`
    };
  }
  
  if (isExecutive) {
    return {
      ...baseContent,
      episode_title: `Executive Excellence: ${userData.guest_name || 'Executive Leader'}'s Leadership Legacy`,
      win_story_1: `As an executive leader, ${userData.guest_name || 'our guest'} successfully transformed organizational culture and drove strategic initiatives that resulted in measurable business growth.`,
      win_story_2: `Through visionary leadership and strategic decision-making, they navigated complex market challenges and positioned their organization for long-term success.`,
      industry_insight: `Based on their executive experience in ${userData.profile_text || 'business leadership'}, they understand the critical importance of adaptive leadership in today's rapidly changing business environment.`,
      question_1: `What shaped your leadership philosophy as a ${userData.job_description || 'senior executive'}, and how do you inspire your teams?`,
      question_2: `Can you share a defining moment in your executive career where your leadership made a significant organizational impact?`,
      question_3: `What advice would you give to emerging leaders about developing executive presence and strategic thinking?`
    };
  }
  
  // General professional content (fallback)
  return {
    ...baseContent,
    win_story_1: `Early in their career, ${userData.guest_name || 'our guest'} demonstrated exceptional ${userData.job_description || 'professional'} skills that set them apart in the industry.`,
    win_story_2: `Through strategic thinking and dedication, they achieved significant milestones in ${userData.profile_text || 'their field'} that showcase their expertise and commitment.`,
    industry_insight: `Based on their experience as a ${userData.job_description || 'professional'}, they've observed key trends and opportunities in today's evolving marketplace.`,
    question_1: `Can you tell us about your journey into ${userData.job_description || 'your current role'} and what initially drew you to this field?`,
    question_2: `What has been the most significant achievement in your career as a ${userData.job_description || 'professional'}, and how did it shape your approach?`,
    question_3: `Looking at the current landscape in ${userData.profile_text || 'your industry'}, what trends do you see emerging and how should professionals prepare?`
  };
}

// 🎯 MAIN PROCESSING
console.log('🎯 Professional Content Generator: Processing request');
console.log('📊 Input data:', JSON.stringify(userData, null, 2));

const professionalContent = generateProfessionalContent(userData);

// Combine with original data and metadata
const result = {
  // Preserve all original input data
  ...userData,
  
  // Add professional content
  ...professionalContent,
  
  // Add metadata
  content_type: "professional",
  ai_model: "hardcoded_professional_v2.0",
  generation_timestamp: new Date().toISOString(),
  content_quality: "professional",
  automation_level: "100%",
  template_source: "intelligent_hardcoded"
};

console.log('✅ Professional content generated successfully');
console.log('📋 Generated fields:', Object.keys(professionalContent));

return [{ json: result }];
