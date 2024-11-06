import { z } from 'zod';

const ACCEPTED_IMAGE_TYPES = ['image/jpg',
  'image/jpeg',
  'image/png',
];

const ACCEPTED_AUDIO_TYPES = [
  'audio/mp3'
];


export const createSongSchema = z.object({
  songFile: z.any()
    .refine((audioFile) => audioFile?.length < 1, { message: "A valid file is required" })
    .refine((audioFile) => ACCEPTED_AUDIO_TYPES.includes(audioFile?.type), { message: "only some image files are accepted" }),
  thumbnail: z.any()
    .refine((thumbnailFile) => thumbnailFile?.length < 1, { message: "Thumbnail file required" })
    .refine((audioFile) => ACCEPTED_IMAGE_TYPES.includes(audioFile?.type), { message: "only some image files are accepted" }),
  songName: z.string({ message: "Song name is required" }).max(120, { message: "Max size for song name is 120 chars" }),
  artistName: z.string({ message: "Artist Name is required" }).max(75, { message: "Max size for Artist Name is 75 chars" }),
  colorHex: z.string({ message: "hex for color is required" }).max(6, { message: "6 digit hex code only" })
});


export type CreateSongDto = z.infer<typeof createSongSchema>


