// This is a minimal schema file
export interface PixelArt {
  id: number;
  prompt: string;
  imageUrl: string;
  createdAt: Date;
}

export interface GeneratePixelArtParams {
  prompt: string;
  style?: string;
  size?: number;
}