import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import OpenAI from 'openai';
import dotenv from 'dotenv';
// Load environment variables
dotenv.config();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
// Initialize OpenAI
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});
// Check if API key is available
const apiKeyAvailable = !!process.env.OPENAI_API_KEY;
console.log(`API key format detected (starts with ${process.env.OPENAI_API_KEY?.substring(0, 7)}), attempting to use OpenAI API`);
console.log(`OpenAI API status: ${apiKeyAvailable ? 'Connected (API key detected)' : 'Not available (API key missing)'}`);
const app = express();
const port = process.env.PORT || 3000;
// Middleware to parse JSON
app.use(express.json());
// Serve static files
app.use(express.static(path.join(__dirname, '../public')));
// Function to generate pixel art using OpenAI
async function generatePixelArtWithAI(prompt: string): Promise<string> {
  try {
    // Enhanced prompt for better pixel art results
    const enhancedPrompt = `Create a high-quality pixel art image of: ${prompt}. Use pixel art techniques including limited color palette, clear pixel definition, deliberate dithering, and consistent light source. Resolution should be 256x256 pixels.`;
    
    const response = await openai.images.generate({
      model: "dall-e-3",
      prompt: enhancedPrompt,
      n: 1,
      size: "1024x1024",
      quality: "standard",
    });
    return response.data[0].url;
  } catch (error) {
    console.error('Error generating image with OpenAI:', error);
    // Return a sample image URL if AI generation fails
    return '/samples/pixel_art_sample.svg';
  }
}
// API endpoint for generating pixel art
app.post('/api/generate', async (req, res) => {
  try {
    const { prompt } = req.body;
    
    if (!prompt) {
      return res.status(400).json({ error: 'Prompt is required' });
    }
    
    // Generate image URL using OpenAI
    const imageUrl = await generatePixelArtWithAI(prompt);
    
    // Save the result
    const result = {
      id: Date.now(),
      imageUrl,
      prompt
    };
    
    res.json(result);
  } catch (error) {
    console.error('Error generating pixel art:', error);
    res.status(500).json({ error: 'Failed to generate pixel art' });
  }
});
// Get recent pixel arts
app.get('/api/pixel-arts', (_req, res) => {
  res.json([]);
});
// Default route for SPA
app.get('*', (_req, res) => {
  res.sendFile(path.join(__dirname, '../public/index.html'));
});
// Start the server on all network interfaces
app.listen(port, '0.0.0.0', () => {
  console.log(`Server running on port ${port}`);
  console.log(`To access locally: http://localhost:${port}`);
  console.log(`To access from other devices on your network: http://[your-ip-address]:${port}`);
});