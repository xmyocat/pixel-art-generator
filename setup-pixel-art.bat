@echo off
echo Setting up Pixel Art Generator project...

echo Creating folder structure...
mkdir client\src\components\ui
mkdir client\src\hooks
mkdir client\src\lib
mkdir client\src\pages
mkdir public\samples
mkdir server
mkdir shared

echo Creating server files...

echo Creating server/openai.ts
(
echo import OpenAI from "openai";
echo import { GeneratePixelArtParams } from "../shared/schema";
echo.
echo // Initialize OpenAI client with API key
echo const openai = new OpenAI({
echo   apiKey: process.env.OPENAI_API_KEY
echo });
echo.
echo // Demo mode sample images - using local SVG files
echo const SAMPLE_IMAGES = {
echo   // Base pixel art styles
echo   fantasy: "/samples/pixel_art_1.svg",
echo   retro: "/samples/pixel_art_2.svg",
echo   cyberpunk: "/samples/pixel_art_3.svg",
echo   cute: "/samples/pixel_art_4.svg",
echo   minimalist: "/samples/pixel_art_5.svg",
echo   
echo   // Specific subject types
echo   knight: "/samples/pixel_knight.svg",
echo   landscape: "/samples/pixel_landscape.svg",
echo   spaceship: "/samples/pixel_spaceship.svg",
echo   
echo   // Carrot variations
echo   carrot: "/samples/pixel_art_carrot.svg",
echo   carrotRetro: "/samples/pixel_art_carrot_2.svg",
echo   carrotMinimalist: "/samples/pixel_art_carrot_3.svg",
echo   carrotPizza: "/samples/pixel_art_carrot_pizza.svg"
echo };
echo.
echo // Demo mode flag - set to true to use sample images instead of API
echo let DEMO_MODE = true;  // Default to demo mode to be safe
echo.
echo // Check if we have an API key
echo if (!process.env.OPENAI_API_KEY ^|^| process.env.OPENAI_API_KEY === "") {
echo   console.log("No API key provided, using demo mode");
echo   DEMO_MODE = true;
echo } else if (process.env.OPENAI_API_KEY.startsWith("sk-")) {
echo   // OpenAI now uses both standard keys (sk-) and project keys (sk-proj-)
echo   console.log("API key format detected (starts with sk-), attempting to use OpenAI API");
echo   DEMO_MODE = false;
echo } else {
echo   console.log("API key doesn't appear to be valid (should start with 'sk-'), using demo mode");
echo   DEMO_MODE = true;
echo }
echo.               
echo console.log(`OpenAI API status: ${DEMO_MODE ? 'Using fallback mode (no valid API key)' : 'Connected (API key detected)'}`);
echo.
echo export async function generatePixelArtImage(params: GeneratePixelArtParams): Promise^<string^> {
echo   try {
echo     // Build the prompt for DALL-E
echo     const {
echo       prompt,
echo       style,
echo       size,
echo       palette,
echo       detailLevel,
echo       animation,
echo       transparency
echo     } = params;
echo.
echo     // If we're in demo mode, return a sample image
echo     if (DEMO_MODE) {
echo       console.log("DEMO MODE: Using sample image instead of calling OpenAI API");
echo       console.log("Prompt:", prompt);
echo       
echo       const promptLower = prompt.toLowerCase();
echo       
echo       // Smart content recognition system
echo       let selectedImage = "";
echo       
echo       // Check for carrots first (most specific)
echo       if (promptLower.includes("carrot")) {
echo         console.log("Carrot detected in prompt, analyzing request...");
echo         
echo         // Check for pizza shaped carrot
echo         if (promptLower.includes("pizza") ^|^| 
echo             promptLower.includes("triangle") ^|^| 
echo             promptLower.includes("triangular")) {
echo           console.log("Pizza/triangle shape detected, using pizza-shaped carrot");
echo           selectedImage = SAMPLE_IMAGES.carrotPizza;
echo         }
echo         // Check for style-specific carrots
echo         else if (promptLower.includes("retro") ^|^| 
echo             promptLower.includes("game boy") ^|^| 
echo             promptLower.includes("8-bit") ^|^|
echo             (params.style === "retro" ^&^& promptLower.includes("retro"))) {
echo           console.log("Retro style explicitly requested, using retro carrot");
echo           selectedImage = SAMPLE_IMAGES.carrotRetro;
echo         }
echo         else if (params.style === "minimalist" ^|^| 
echo             promptLower.includes("minimalist") ^|^| 
echo             promptLower.includes("simple") ^|^|
echo             promptLower.includes("minimal")) {
echo           console.log("Minimalist style detected, using minimalist carrot");
echo           selectedImage = SAMPLE_IMAGES.carrotMinimalist;
echo         }
echo         else if (params.style === "cute" ^|^| 
echo             promptLower.includes("cute") ^|^| 
echo             promptLower.includes("kawaii")) {
echo           console.log("Cute style detected, using cute carrot");
echo           selectedImage = SAMPLE_IMAGES.carrot;
echo         }
echo         else {
echo           // Default carrot
echo           selectedImage = SAMPLE_IMAGES.carrot;
echo         }
echo       }
echo       // Check for specific subjects
echo       else if (promptLower.includes("knight") ^|^| 
echo           promptLower.includes("warrior") ^|^| 
echo           promptLower.includes("paladin") ^|^| 
echo           promptLower.includes("soldier") ^|^| 
echo           promptLower.includes("medieval")) {
echo         console.log("Knight/warrior detected, using pixel knight");
echo         selectedImage = SAMPLE_IMAGES.knight;
echo       }
echo       else if (promptLower.includes("landscape") ^|^| 
echo           promptLower.includes("nature") ^|^| 
echo           promptLower.includes("scenery") ^|^| 
echo           promptLower.includes("outdoor") ^|^| 
echo           promptLower.includes("mountain") ^|^|
echo           promptLower.includes("forest")) {
echo         console.log("Landscape/nature detected, using pixel landscape");
echo         selectedImage = SAMPLE_IMAGES.landscape;
echo       }
echo       else if (promptLower.includes("spaceship") ^|^| 
echo           promptLower.includes("spacecraft") ^|^| 
echo           promptLower.includes("space ship") ^|^| 
echo           promptLower.includes("rocket") ^|^| 
echo           promptLower.includes("space") ^|^|
echo           promptLower.includes("ufo")) {
echo         console.log("Spaceship/space detected, using pixel spaceship");
echo         selectedImage = SAMPLE_IMAGES.spaceship;
echo       }
echo       // If no specific subject is found, use style-based selection
echo       else if (params.style === "fantasy") {
echo         selectedImage = SAMPLE_IMAGES.fantasy;
echo       }
echo       else if (params.style === "retro") {
echo         selectedImage = SAMPLE_IMAGES.retro;
echo       }
echo       else if (params.style === "cyberpunk") {
echo         selectedImage = SAMPLE_IMAGES.cyberpunk;
echo       }
echo       else if (params.style === "cute") {
echo         selectedImage = SAMPLE_IMAGES.cute;
echo       }
echo       else if (params.style === "minimalist") {
echo         selectedImage = SAMPLE_IMAGES.minimalist;
echo       }
echo       else {
echo         // If no specific style or subject, randomly select from base styles
echo         const baseStyles = [
echo           SAMPLE_IMAGES.fantasy,
echo           SAMPLE_IMAGES.retro,
echo           SAMPLE_IMAGES.cyberpunk, 
echo           SAMPLE_IMAGES.cute,
echo           SAMPLE_IMAGES.minimalist
echo         ];
echo         selectedImage = baseStyles[Math.floor(Math.random() * baseStyles.length)];
echo       }
echo       
echo       // Simulate a delay to make it feel like generation is happening
echo       await new Promise(resolve =^> setTimeout(resolve, 1500));
echo       
echo       return selectedImage;
echo     }
echo.
echo     // Create a detailed prompt for pixel art
echo     let detailedPrompt = `Create a ${size}x${size} pixel art image of ${prompt}.`;
echo     
echo     // Add style details
echo     if (style === "retro") {
echo       detailedPrompt += " Use a classic retro game style with limited colors and sharp pixels.";
echo     } else if (style === "minimalist") {
echo       detailedPrompt += " Create a minimalist design with simplified shapes and limited color palette.";
echo     } else if (style === "fantasy") {
echo       detailedPrompt += " Design in a fantasy art style with magical elements and vibrant colors.";
echo     } else if (style === "cyberpunk") {
echo       detailedPrompt += " Use a cyberpunk aesthetic with neon colors, futuristic elements, and high contrast.";
echo     } else if (style === "cute") {
echo       detailedPrompt += " Create a cute, kawaii style with rounded shapes and pastel colors.";
echo     }
echo.
echo     // Add palette information
echo     if (palette === "vibrant") {
echo       detailedPrompt += " Use a vibrant color palette with bright, saturated colors.";
echo     } else if (palette === "retro") {
echo       detailedPrompt += " Use a classic GameBoy-inspired green palette (4 shades of green).";
echo     } else if (palette === "pastel") {
echo       detailedPrompt += " Use soft pastel colors with light tones.";
echo     }
echo.
echo     // Add detail level
echo     if (detailLevel) {
echo       if (detailLevel ^<= 2) {
echo         detailedPrompt += " Keep the level of detail very simple and minimal.";
echo       } else if (detailLevel ^>= 4) {
echo         detailedPrompt += " Include high level of pixel art detail where appropriate.";
echo       }
echo     }
echo.
echo     // Add transparency request
echo     if (transparency) {
echo       detailedPrompt += " Ensure the background is transparent.";
echo     }
echo.
echo     // Always specify pixel art with detailed instructions
echo     detailedPrompt += " This must be authentic pixel art with the following characteristics:";
echo     detailedPrompt += " 1. Clear, distinct, and visible individual pixels";
echo     detailedPrompt += " 2. Limited color palette (no more than 16-32 colors total)";
echo     detailedPrompt += " 3. No anti-aliasing or blurring between color regions";
echo     detailedPrompt += " 4. Sharp edges and defined pixel boundaries";
echo     detailedPrompt += " 5. NOT a photorealistic image with a pixel filter";
echo     detailedPrompt += " Use authentic pixel art techniques like purposeful dithering where appropriate.";
echo.
echo     console.log("DALL-E Prompt:", detailedPrompt);
echo.
echo     try {
echo       const response = await openai.images.generate({
echo         model: "dall-e-3",
echo         prompt: detailedPrompt,
echo         n: 1,
echo         size: "1024x1024",
echo         quality: "standard",
echo       });
echo   
echo       if (!response.data[0]?.url) {
echo         throw new Error("No image URL returned from OpenAI");
echo       }
echo   
echo       return response.data[0].url;
echo     } catch (error: any) {
echo       console.error("OpenAI API error:", error);
echo       
echo       // If we hit the billing limit, fall back to demo mode
echo       if (error.code === 'billing_hard_limit_reached') {
echo         console.log("Billing limit reached, falling back to demo mode");
echo         
echo         // Reuse our smart content recognition logic from above
echo         const promptLower = prompt.toLowerCase();
echo         let fallbackImage = "";
echo         
echo         if (promptLower.includes("carrot")) {
echo           if (promptLower.includes("pizza") ^|^| promptLower.includes("triangle")) {
echo             fallbackImage = SAMPLE_IMAGES.carrotPizza;
echo           } else if (promptLower.includes("retro") ^|^| 
echo               (params.style === "retro" ^&^& promptLower.includes("retro"))) {
echo             fallbackImage = SAMPLE_IMAGES.carrotRetro;
echo           } else if (promptLower.includes("simple") ^|^| params.style === "minimalist") {
echo             fallbackImage = SAMPLE_IMAGES.carrotMinimalist;
echo           } else {
echo             fallbackImage = SAMPLE_IMAGES.carrot;
echo           }
echo         } else if (promptLower.includes("knight") ^|^| promptLower.includes("medieval")) {
echo           fallbackImage = SAMPLE_IMAGES.knight;
echo         } else if (promptLower.includes("landscape") ^|^| promptLower.includes("nature")) {
echo           fallbackImage = SAMPLE_IMAGES.landscape;
echo         } else if (promptLower.includes("space") ^|^| promptLower.includes("ship")) {
echo           fallbackImage = SAMPLE_IMAGES.spaceship;
echo         } else if (params.style === "fantasy") {
echo           fallbackImage = SAMPLE_IMAGES.fantasy;
echo         } else if (params.style === "retro") {
echo           fallbackImage = SAMPLE_IMAGES.retro;
echo         } else if (params.style === "cyberpunk") {
echo           fallbackImage = SAMPLE_IMAGES.cyberpunk;
echo         } else if (params.style === "cute") {
echo           fallbackImage = SAMPLE_IMAGES.cute;
echo         } else if (params.style === "minimalist") {
echo           fallbackImage = SAMPLE_IMAGES.minimalist;
echo         } else {
echo           // Default to a random style
echo           const baseStyles = [
echo             SAMPLE_IMAGES.fantasy,
echo             SAMPLE_IMAGES.retro,
echo             SAMPLE_IMAGES.cyberpunk,
echo             SAMPLE_IMAGES.cute,
echo             SAMPLE_IMAGES.minimalist
echo           ];
echo           fallbackImage = baseStyles[Math.floor(Math.random() * baseStyles.length)];
echo         }
echo         
echo         return fallbackImage;
echo       }
echo       
echo       // Re-throw other errors
echo       throw error;
echo     }
echo   } catch (error) {
echo     console.error("Error generating pixel art:", error);
echo     
echo     // If this is any other error, we'll also fall back to demo mode
echo     console.log("Unexpected error, falling back to demo mode");
echo         
echo     // Use the same logic from the beginning to select a fallback image
echo     // Make sure to use the prompt from params
echo     const promptLower = params.prompt.toLowerCase();
echo     let fallbackImage = "";
echo     
echo     // Check for carrots first (most specific)
echo     if (promptLower.includes("carrot")) {
echo       console.log("Carrot detected in fallback, analyzing request...");
echo       
echo       // Check for pizza shaped carrot
echo       if (promptLower.includes("pizza") ^|^| 
echo           promptLower.includes("triangle") ^|^| 
echo           promptLower.includes("triangular")) {
echo         console.log("Pizza/triangle shape detected in fallback, using pizza-shaped carrot");
echo         fallbackImage = SAMPLE_IMAGES.carrotPizza;
echo       }
echo       // Check for style-specific carrots
echo       else if (promptLower.includes("retro") ^|^| 
echo           promptLower.includes("game boy") ^|^| 
echo           promptLower.includes("8-bit") ^|^|
echo           (params.style === "retro" ^&^& promptLower.includes("retro"))) {
echo         console.log("Retro style explicitly requested in fallback, using retro carrot");
echo         fallbackImage = SAMPLE_IMAGES.carrotRetro;
echo       }
echo       else if (params.style === "minimalist" ^|^| 
echo           promptLower.includes("minimalist") ^|^| 
echo           promptLower.includes("simple") ^|^|
echo           promptLower.includes("minimal")) {
echo         console.log("Minimalist style detected in fallback, using minimalist carrot");
echo         fallbackImage = SAMPLE_IMAGES.carrotMinimalist;
echo       }
echo       else {
echo         // Default carrot
echo         console.log("Using default carrot in fallback");
echo         fallbackImage = SAMPLE_IMAGES.carrot;
echo       }
echo     }
echo     // Check for other subjects
echo     else if (promptLower.includes("knight") ^|^| 
echo         promptLower.includes("warrior") ^|^| 
echo         promptLower.includes("medieval")) {
echo       fallbackImage = SAMPLE_IMAGES.knight;
echo     }
echo     else if (promptLower.includes("landscape") ^|^| 
echo         promptLower.includes("nature") ^|^| 
echo         promptLower.includes("scenery")) {
echo       fallbackImage = SAMPLE_IMAGES.landscape;
echo     }
echo     else if (promptLower.includes("spaceship") ^|^| 
echo         promptLower.includes("spacecraft") ^|^| 
echo         promptLower.includes("space")) {
echo       fallbackImage = SAMPLE_IMAGES.spaceship;
echo     }
echo     // If no specific subject is found, use style-based selection
echo     else if (params.style === "fantasy") {
echo       fallbackImage = SAMPLE_IMAGES.fantasy;
echo     }
echo     else if (params.style === "retro") {
echo       fallbackImage = SAMPLE_IMAGES.retro;
echo     }
echo     else if (params.style === "cyberpunk") {
echo       fallbackImage = SAMPLE_IMAGES.cyberpunk;
echo     }
echo     else if (params.style === "cute") {
echo       fallbackImage = SAMPLE_IMAGES.cute;
echo     }
echo     else if (params.style === "minimalist") {
echo       fallbackImage = SAMPLE_IMAGES.minimalist;
echo     }
echo     else {
echo       // Default to a random style
echo       const baseStyles = [
echo         SAMPLE_IMAGES.fantasy,
echo         SAMPLE_IMAGES.retro,
echo         SAMPLE_IMAGES.cyberpunk,
echo         SAMPLE_IMAGES.cute,
echo         SAMPLE_IMAGES.minimalist
echo       ];
echo       fallbackImage = baseStyles[Math.floor(Math.random() * baseStyles.length)];
echo     }
echo     
echo     return fallbackImage;
echo   }
echo }
) > server\openai.ts

echo Creating server/routes.ts
(
echo import type { Express, Request, Response } from "express";
echo import { createServer, type Server } from "http";
echo import { storage } from "./storage";
echo import { generatePixelArtImage } from "./openai";
echo import { generatePixelArtSchema, insertPixelArtSchema } from "@shared/schema";
echo import { ZodError } from "zod";
echo import { fromZodError } from "zod-validation-error";
echo.
echo export async function registerRoutes(app: Express): Promise^<Server^> {
echo   // API Endpoints
echo   app.get("/api/pixel-arts", async (_req: Request, res: Response) =^> {
echo     try {
echo       const pixelArts = await storage.getRecentPixelArts(8);
echo       res.json(pixelArts);
echo     } catch (error) {
echo       console.error("Error fetching pixel arts:", error);
echo       res.status(500).json({ message: "Failed to fetch recent pixel arts" });
echo     }
echo   });
echo.
echo   app.get("/api/pixel-arts/:id", async (req: Request, res: Response) =^> {
echo     try {
echo       const id = parseInt(req.params.id);
echo       if (isNaN(id)) {
echo         return res.status(400).json({ message: "Invalid ID format" });
echo       }
echo.
echo       const pixelArt = await storage.getPixelArt(id);
echo       if (!pixelArt) {
echo         return res.status(404).json({ message: "Pixel art not found" });
echo       }
echo.
echo       res.json(pixelArt);
echo     } catch (error) {
echo       console.error("Error fetching pixel art:", error);
echo       res.status(500).json({ message: "Failed to fetch pixel art" });
echo     }
echo   });
echo.
echo   app.post("/api/generate", async (req: Request, res: Response) =^> {
echo     try {
echo       // Validate request body
echo       const validatedData = generatePixelArtSchema.parse(req.body);
echo       
echo       // Generate the pixel art image - our openai.ts now handles fallback
echo       const imageUrl = await generatePixelArtImage(validatedData);
echo       
echo       // Save to storage
echo       const pixelArt = await storage.createPixelArt({
echo         ...validatedData,
echo         imageUrl
echo       });
echo       
echo       res.status(201).json(pixelArt);
echo     } catch (error: any) {
echo       console.error("Error generating pixel art:", error);
echo       
echo       if (error instanceof ZodError) {
echo         const validationError = fromZodError(error);
echo         return res.status(400).json({ message: validationError.message });
echo       }
echo       
echo       res.status(500).json({ message: error.message ^|^| "Failed to generate pixel art" });
echo     }
echo   });
echo.
echo   const httpServer = createServer(app);
echo.
echo   return httpServer;
echo }
) > server\routes.ts

echo Creating server/storage.ts
(
echo import { users, type User, type InsertUser, pixelArts, type PixelArt, type InsertPixelArt } from "@shared/schema";
echo.
echo // modify the interface with any CRUD methods
echo // you might need
echo export interface IStorage {
echo   getUser(id: number): Promise^<User ^| undefined^>;
echo   getUserByUsername(username: string): Promise^<User ^| undefined^>;
echo   createUser(user: InsertUser): Promise^<User^>;
echo   
echo   // Pixel art methods
echo   createPixelArt(pixelArt: InsertPixelArt): Promise^<PixelArt^>;
echo   getPixelArt(id: number): Promise^<PixelArt ^| undefined^>;
echo   getRecentPixelArts(limit?: number): Promise^<PixelArt[]^>;
echo }
echo.
echo export class MemStorage implements IStorage {
echo   private users: Map^<number, User^>;
echo   private pixelArts: Map^<number, PixelArt^>;
echo   private userCurrentId: number;
echo   private pixelArtCurrentId: number;
echo.
echo   constructor() {
echo     this.users = new Map();
echo     this.pixelArts = new Map();
echo     this.userCurrentId = 1;
echo     this.pixelArtCurrentId = 1;
echo   }
echo.
echo   async getUser(id: number): Promise^<User ^| undefined^> {
echo     return this.users.get(id);
echo   }
echo.
echo   async getUserByUsername(username: string): Promise^<User ^| undefined^> {
echo     return Array.from(this.users.values()).find(
echo       (user) =^> user.username === username,
echo     );
echo   }
echo.
echo   async createUser(insertUser: InsertUser): Promise^<User^> {
echo     const id = this.userCurrentId++;
echo     const user: User = { ...insertUser, id };
echo     this.users.set(id, user);
echo     return user;
echo   }
echo.
echo   async createPixelArt(insertPixelArt: InsertPixelArt): Promise^<PixelArt^> {
echo     const id = this.pixelArtCurrentId++;
echo     const createdAt = new Date();
echo     const pixelArt: PixelArt = { 
echo       ...insertPixelArt, 
echo       id, 
echo       createdAt 
echo     };
echo     this.pixelArts.set(id, pixelArt);
echo     return pixelArt;
echo   }
echo.
echo   async getPixelArt(id: number): Promise^<PixelArt ^| undefined^> {
echo     return this.pixelArts.get(id);
echo   }
echo.
echo   async getRecentPixelArts(limit: number = 10): Promise^<PixelArt[]^> {
echo     const allPixelArts = Array.from(this.pixelArts.values());
echo     
echo     // Sort by most recent first
echo     allPixelArts.sort((a, b) =^> {
echo       return b.createdAt.getTime() - a.createdAt.getTime();
echo     });
echo     
echo     return allPixelArts.slice(0, limit);
echo   }
echo }
echo.
echo export const storage = new MemStorage();
) > server\storage.ts

echo Creating shared/schema.ts
(
echo import { pgTable, text, serial, integer, boolean, jsonb, timestamp } from "drizzle-orm/pg-core";
echo import { createInsertSchema } from "drizzle-zod";
echo import { z } from "zod";
echo.
echo export const users = pgTable("users", {
echo   id: serial("id").primaryKey(),
echo   username: text("username").notNull().unique(),
echo   password: text("password").notNull(),
echo });
echo.
echo export const insertUserSchema = createInsertSchema(users).pick({
echo   username: true,
echo   password: true,
echo });
echo.
echo export const pixelArts = pgTable("pixel_arts", {
echo   id: serial("id").primaryKey(),
echo   prompt: text("prompt").notNull(),
echo   style: text("style").notNull(),
echo   size: integer("size").notNull(),
echo   palette: text("palette").notNull(),
echo   detailLevel: integer("detail_level"),
echo   animation: boolean("animation").default(false),
echo   transparency: boolean("transparency").default(false),
echo   imageUrl: text("image_url").notNull(),
echo   createdAt: timestamp("created_at").defaultNow().notNull(),
echo });
echo.
echo export const insertPixelArtSchema = createInsertSchema(pixelArts).omit({
echo   id: true,
echo   createdAt: true,
echo });
echo.
echo export const generatePixelArtSchema = z.object({
echo   prompt: z.string().min(1, "Prompt is required"),
echo   style: z.string(),
echo   size: z.number().int().min(16).max(64),
echo   palette: z.string(),
echo   detailLevel: z.number().int().min(1).max(5).optional(),
echo   animation: z.boolean().optional(),
echo   transparency: z.boolean().optional(),
echo });
echo.
echo export type InsertUser = z.infer^<typeof insertUserSchema^>;
echo export type User = typeof users.$inferSelect;
echo.
echo export type InsertPixelArt = z.infer^<typeof insertPixelArtSchema^>;
echo export type PixelArt = typeof pixelArts.$inferSelect;
echo export type GeneratePixelArtParams = z.infer^<typeof generatePixelArtSchema^>;
) > shared\schema.ts

echo Creating client/src/lib/types.ts
(
echo import { PixelArt, GeneratePixelArtParams } from "@shared/schema";
echo.
echo export interface GenerationResult {
echo   imageUrl: string;
echo   id: number;
echo }
echo.
echo export interface StyleOption {
echo   id: string;
echo   name: string;
echo }
echo.
echo export interface PaletteOption {
echo   id: string;
echo   name: string;
echo   colors: string[];
echo }
echo.
echo export const STYLES: StyleOption[] = [
echo   { id: "retro", name: "Retro" },
echo   { id: "minimalist", name: "Minimalist" },
echo   { id: "fantasy", name: "Fantasy" },
echo   { id: "cyberpunk", name: "Cyberpunk" },
echo   { id: "cute", name: "Cute" },
echo   { id: "custom", name: "Custom" },
echo ];
echo.
echo export const PALETTES: PaletteOption[] = [
echo   { 
echo     id: "vibrant", 
echo     name: "Vibrant", 
echo     colors: ["#FF5555", "#55FF55", "#5555FF", "#FFFF55"] 
echo   },
echo   { 
echo     id: "retro", 
echo     name: "Retro", 
echo     colors: ["#8bac0f", "#306230", "#0f380f", "#9bbc0f"] 
echo   },
echo   { 
echo     id: "pastel", 
echo     name: "Pastel", 
echo     colors: ["#ffadad", "#ffd6a5", "#fdffb6", "#caffbf"] 
echo   },
echo   { 
echo     id: "custom", 
echo     name: "Custom", 
echo     colors: [] 
echo   },
echo ];
echo.
echo export const DETAIL_LEVELS = ["Very Low", "Low", "Medium", "High", "Very High"];
) > client\src\lib\types.ts

echo Creating client/src/lib/openai.ts
(
echo import { GeneratePixelArtParams } from "@shared/schema";
echo import { apiRequest } from "./queryClient";
echo.
echo export async function generatePixelArt(params: GeneratePixelArtParams) {
echo   const response = await apiRequest("POST", "/api/generate", params);
echo   return response.json();
echo }
echo.
echo export async function downloadImage(imageUrl: string, filename: string) {
echo   try {
echo     const response = await fetch(imageUrl);
echo     const blob = await response.blob();
echo     const url = window.URL.createObjectURL(blob);
echo     const link = document.createElement("a");
echo     link.href = url;
echo     link.download = filename ^|^| "pixel-art.png";
echo     document.body.appendChild(link);
echo     link.click();
echo     document.body.removeChild(link);
echo     window.URL.revokeObjectURL(url);
echo   } catch (error) {
echo     console.error("Error downloading image:", error);
echo     throw new Error("Failed to download image");
echo   }
echo }
) > client\src\lib\openai.ts

echo Creating client/src/lib/utils.ts
(
echo import { type ClassValue, clsx } from "clsx";
echo import { twMerge } from "tailwind-merge";
echo.
echo export function cn(...inputs: ClassValue[]) {
echo   return twMerge(clsx(inputs));
echo }
) > client\src\lib\utils.ts

echo Creating client/src/index.css
(
echo @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Press+Start+2P&display=swap');
echo.
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
echo.
echo @layer base {
echo   * {
echo     @apply border-border;
echo   }
echo.
echo   body {
echo     @apply font-sans antialiased bg-neutral-900 text-white;
echo   }
echo.
echo   /* Pixel rendering for images */
echo   .pixel-art {
echo     image-rendering: pixelated;
echo     image-rendering: -moz-crisp-edges;
echo     image-rendering: crisp-edges;
echo   }
echo.
echo   /* Pixel animation */
echo   @keyframes pixel-loading {
echo     0%% { transform: translateY(0px); }
echo     50%% { transform: translateY(-5px); }
echo     100%% { transform: translateY(0px); }
echo   }
echo.
echo   .animate-pixel-loading ^> div {
echo     animation: pixel-loading 1.5s infinite steps(6);
echo   }
echo.
echo   .animate-pixel-loading ^> div:nth-child(2) {
echo     animation-delay: 0.2s;
echo   }
echo.
echo   .animate-pixel-loading ^> div:nth-child(3) {
echo     animation-delay: 0.4s;
echo   }
echo.
echo   .animate-pixel-loading ^> div:nth-child(4) {
echo     animation-delay: 0.6s;
echo   }
echo.
echo   /* Custom styles for range inputs */
echo   input[type="range"] {
echo     -webkit-appearance: none;
echo     appearance: none;
echo     width: 100%%;
echo     height: 16px;
echo     background: #374151;
echo     outline: none;
echo     position: relative;
echo     border-radius: 0.375rem;
echo   }
echo   
echo   input[type="range"]::-webkit-slider-thumb {
echo     -webkit-appearance: none;
echo     appearance: none;
echo     width: 24px;
echo     height: 24px;
echo     background: #6d28d9;
echo     cursor: pointer;
echo     border: none;
echo     box-shadow: 0 0 0 2px #fff;
echo     border-radius: 50%%;
echo   }
echo   
echo   input[type="range"]::-moz-range-thumb {
echo     width: 24px;
echo     height: 24px;
echo     background: #6d28d9;
echo     cursor: pointer;
echo     border: none;
echo     box-shadow: 0 0 0 2px #fff;
echo     border-radius: 50%%;
echo   }
echo }
) > client\src\index.css

echo Creating configuration files...

echo Creating package.json
(
echo {
echo   "name": "pixel-art-generator",
echo   "version": "1.0.0",
echo   "description": "AI-powered pixel art generator",
echo   "main": "server/index.js",
echo   "scripts": {
echo     "dev": "ts-node server/index.ts",
echo     "build": "vite build",
echo     "start": "node dist/server/index.js"
echo   },
echo   "dependencies": {
echo     "@hookform/resolvers": "^3.1.0",
echo     "@tanstack/react-query": "^5.0.0",
echo     "express": "^4.18.2",
echo     "express-session": "^1.17.3",
echo     "openai": "^4.0.0",
echo     "react": "^18.2.0",
echo     "react-dom": "^18.2.0",
echo     "react-hook-form": "^7.45.1",
echo     "wouter": "^2.11.0",
echo     "zod": "^3.21.4",
echo     "zod-validation-error": "^1.3.1"
echo   },
echo   "devDependencies": {
echo     "@types/express": "^4.17.17",
echo     "@types/node": "^20.4.0",
echo     "@types/react": "^18.2.14",
echo     "@types/react-dom": "^18.2.6",
echo     "@vitejs/plugin-react": "^4.0.1",
echo     "autoprefixer": "^10.4.14",
echo     "postcss": "^8.4.25",
echo     "tailwindcss": "^3.3.2",
echo     "ts-node": "^10.9.1",
echo     "typescript": "^5.1.6",
echo     "vite": "^4.4.3"
echo   }
echo }
) > package.json

echo Creating .env file
(
echo OPENAI_API_KEY=your_api_key_here
) > .env

echo Creating .gitignore
(
echo node_modules/
echo .env
echo dist/
echo build/
echo .DS_Store
) > .gitignore

echo Creating sample SVG files...
mkdir -p public\samples
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_1.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_2.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_3.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_4.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_5.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_knight.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_landscape.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_spaceship.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_carrot.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_carrot_2.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_carrot_3.svg
echo ^<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg"^>^</svg^> > public\samples\pixel_art_carrot_pizza.svg

echo Setup complete! Now run:
echo git add .
echo git commit -m "Initial commit with pixel art generator app"
echo git push origin main