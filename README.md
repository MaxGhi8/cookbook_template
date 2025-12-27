# CookBook LaTeX Class

A custom LaTeX class for creating beautiful, visual-rich cookbooks. This class is designed to be easy to use while producing professional-looking PDF outputs with full-page background images, recipe layouts, and elegant typography.

## features

- **Custom Geometry**: Optimized margins for recipe layouts.
- **Beautiful Typography**: Uses Palatino (serif) for body text and Helvetica (sans-serif) for headers.
- **Visuals**: Native support for full-page backgrounds and recipe images.
- **Icons**: Integrated FontAwesome 5 icons for visual cues (Time, Ingredients, Preparation).
- **Multilingual Ready**: Currently set to **English**, but supports easy switching (e.g., to Italian).

## Getting Started

1.  Ensure your `.tex` file starts with `\documentclass{cookbook}`.
2.  Place your recipe images in the same directory or a subfolder (e.g., `photos/`) specifing it.
3.  Use the provided commands to structure your book and add recipes.

## Command Reference

### Structural Commands

#### `\chapterBg{Title}{ImageFile}`
Creates a new chapter with a dedicated title page and a full-page background image.
- **Title**: The name of the chapter (e.g., "Appetizers").
- **ImageFile**: The filename of the background image (e.g., `chapter_cover.jpg`).

#### `\sectionBg{Title}{ImageFile}`
Creates a new section (sub-category) with a dedicated title page and background image.
- Useful for dividing chapters (e.g., "Vegetarian", "Meat").

### Recipe Layouts

The class provides three main layouts for recipes.

#### 1. `\recipeOnePage`
A balanced layout with ingredients and image on the top half, and preparation steps on the bottom.

```latex
\recipeOnePage{Recipe Title}
    {Servings | Time}
    {
        \item Ingredient 1
        \item Ingredient 2
    }
    {Short description of the dish.}
    {
        \item Step 1 of preparation.
        \item Step 2...
    }
    {Optional Chef's Tip}
    {image_filename}
```

#### 2. `\recipeTextOnly`
Ideal for simple recipes or when no photo is available. It uses a clean, two-column layout for ingredients.

```latex
\recipeTextOnly{Recipe Title}
    {Servings | Time}
    {
        \item Ingredient 1...
    }
    {Description}
    {
        \item Preparation steps...
    }
    {Chef's Tip}
```

#### 3. `\recipeBottomImage`
Places the text at the top and a large, wide cropped image at the bottom of the page. Great for showing off textures.

```latex
\recipeBottomImage{Recipe Title}
    {Servings | Time}
    {Ingredients...}
    {Description}
    {Preparation...}
    {Chef's Tip}
    {image_filename}
```

### Visual Helpers

#### `\setBackground{ImageFile}`
Sets a full-page background image for the **current page only**.
- Use this on standard text pages or the title page to add atmosphere.
- The image is set with `opacity=0.2` to ensure text remains readable.

#### `\imagePage{ImageFile}`
Inserts a full page consisting **only** of an image (full bleed).
- Useful for showcase photos between recipes.

## Icons Used
- Clock: `\faIcon{clock}` (Time/Servings)
- Shopping Cart: `\faIcon{shopping-cart}` (Ingredients)
- Utensils: `\faIcon{utensils}` (Preparation)
- Pen: `\faIcon{pen}` (Description)
- Lightbulb: `\faIcon{lightbulb}` (Chef's Tip)

## Colors
The class defines three main colors you can customize in `cookbook.cls`:
- `TitleColor`: Dark Brown (RGB 100, 50, 0)
- `SectionColor`: Medium Brown (RGB 80, 40, 0)
- `TextColor`: Black (RGB 0, 0, 0)