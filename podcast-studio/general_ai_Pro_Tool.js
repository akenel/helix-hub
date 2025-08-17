// Tool Name: generate_podcast_content
// Tool Description: Generate professional podcast interview content

const userData = $json;

// Hardcoded professional content template
const professionalContent = {
  "episode_title": `Professional Spotlight: ${userData.guest_name || userData.name || "Industry Leader"}'s Career Journey`,
  "guest_bio": `Meet ${userData.guest_name || userData.name || "our guest"}, a ${userData.job_description || "professional"} with expertise in ${userData.profile_text || "their field"}. Join us as we explore their career insights and industry experience.`,
  "win_story_1": `Early in their career, ${userData.guest_name || "our guest"} demonstrated exceptional ${userData.job_description || "professional"} skills that set them apart in the industry.`,
  "win_story_2": `Through strategic thinking and dedication, they achieved significant milestones in ${userData.profile_text || "their field"} that showcase their leadership capabilities.`,
  "industry_insight": `Based on their experience as a ${userData.job_description || "professional"}, they've observed key trends and opportunities in today's evolving marketplace.`,
  "question_1": `Can you tell us about your journey into ${userData.job_description || "your current role"} and what initially drew you to this field?`,
  "question_2": `What has been the most significant achievement in your career as a ${userData.job_description || "professional"}, and how did it shape your approach?`,
  "question_3": `Looking at the current landscape in ${userData.profile_text || "your industry"}, what trends do you see emerging and how should professionals prepare?`,
  "professional_bio": `${userData.guest_name || "Our guest"} brings extensive experience in ${userData.profile_text || "their field"} as a ${userData.job_description || "professional"}. Their career demonstrates a commitment to excellence and innovation that has made them a respected voice in the industry.`,
  "talking_points": `Key discussion areas include: professional development in ${userData.profile_text || "the industry"}, leadership lessons from ${userData.job_description || "their role"}, industry trends and future outlook, career advice for aspiring professionals.`
};

return professionalContent;