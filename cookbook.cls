\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cookbook}[2025/12/24 Custom Cookbook Class]

\LoadClass[11pt, openany]{book}

% Required Packages
\RequirePackage[a4paper, margin=3cm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{multicol}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[italian]{babel}

% Fonts (Standard reliable fonts)
\RequirePackage{mathpazo} % Palatino font for a classic look
\RequirePackage{helvet}   % Helvetica for sans-serif
\RequirePackage{fontawesome5} % Icons

% Background support
\RequirePackage{eso-pic}
\RequirePackage{tikz}

% Command to set background for the CURRENT page only
\newcommand{\setBackground}[1]{
    \AddToShipoutPictureBG*{
        \begin{tikzpicture}[remember picture, overlay]
            \node[opacity=0.1, inner sep=0pt] at (current page.center) {
                \includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio=false]{#1}
            };
        \end{tikzpicture}
    }
}

% Convenience command for Chapter with Background
% Usage: \chapterBg{Chapter Title}{BackgroundImage}
\newcommand{\chapterBg}[2]{
    \chapter{#1}
    \setBackground{#2}
}

% Colors
\definecolor{TitleColor}{RGB}{100, 50, 0}
\definecolor{SectionColor}{RGB}{80, 40, 0}
\definecolor{TextColor}{RGB}{0, 0, 0} % Black for text
\color{TextColor}

% Page Style
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}

\RequirePackage{etoolbox}

% Chapter Image Support
\newcommand{\chapterImage}{}
\newcommand{\setChapterImage}[1]{\renewcommand{\chapterImage}{#1}}

% Helper command to print the chapter image if it exists
\newcommand{\printChapterImage}{%
  \ifdefempty{\chapterImage}{\vspace{2cm}}{%
     \par\vspace{1cm}%
     \includegraphics[width=\textwidth,height=6cm,keepaspectratio]{\chapterImage}%
     \global\let\chapterImage\empty%
     \vspace{1cm}%
  }%
}

% Title Formatting
\titleformat{\chapter}[display]
  {\centering\normalfont\sffamily}
  {\thispagestyle{empty}\vspace*{2cm}\Huge\bfseries\color{TitleColor}\chaptertitlename\ \thechapter}
  {20pt}
  {\titlerule[2pt]\vspace{1ex}\Huge\bfseries\color{SectionColor}}
  [{\vspace{1ex}\titlerule[2pt]\printChapterImage}]

\titlespacing*{\chapter}{0pt}{0pt}{40pt}

\titleformat{\section}
  {\normalfont\sffamily\Large\bfseries\color{SectionColor}}
  {\thesection}{1em}{}

% Custom Commands for Recipes

% 1. Two Pages Layout: Text on Left, Full Image on Right
% Usage: \recipeTwoPages{Title}{Servings/Time}{Ingredients}{Description}{Instructions}{Suggestion}{ImageFile}
\newcommand{\recipeTwoPages}[7]{
    \clearpage
    \thispagestyle{plain}
    
    % LEFT PAGE: CONTENT
    \begin{minipage}[t][\textheight][t]{\textwidth}
        {\sffamily\Huge\bfseries\color{TitleColor} #1}
        \par\vspace{0.5cm}
        {\large\bfseries\color{SectionColor} 
         \faIcon{clock}\ #2}
        \par\vspace{1cm}
        
        \section*{Ingredienti \faIcon{shopping-cart}}
        \begin{multicols}{2}
            \begin{itemize}[noitemsep]
                #3
            \end{itemize}
        \end{multicols}
        
        % Description (Optional)
        \ifstrempty{#4}{}{
            \vspace{0.3cm}
            {\noindent\bfseries\color{TextColor} \faIcon{pen}\ Descrizione:} #4
        }
        
        \vspace{0.5cm}
        \section*{Preparazione \faIcon{utensils}}
        \begin{enumerate}
            #5
        \end{enumerate}

        % Suggestion (Optional)
        \ifstrempty{#6}{}{
            \vfill
            \noindent
            {\color{SectionColor}\rule{\linewidth}{0.5pt}}\\[0.2cm]
            {\bfseries\itshape\color{TitleColor} \faIcon{lightbulb}\ Il Consiglio dello Chef:} #6
        }
    \end{minipage}
    
    \clearpage
    \thispagestyle{empty}
    
    % RIGHT PAGE: IMAGE
    \newgeometry{margin=0cm}
    \noindent
    \includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio=false]{#7}
    \restoregeometry
    \clearpage
}

% 2. One Page Layout: Text and Image split
% Usage: \recipeOnePage{Title}{Servings/Time}{Ingredients}{Description}{Instructions}{Suggestion}{ImageFile}
\newcommand{\recipeOnePage}[7]{
    \clearpage
    {\sffamily\Huge\bfseries\color{TitleColor} #1}
    \par\vspace{0.2cm}
    {\large\bfseries\color{SectionColor} 
         \faIcon{clock}\ #2}
    \par\vspace{0.5cm}
    
    \begin{minipage}[t]{0.55\textwidth}
        \section*{Ingredienti \faIcon{shopping-cart}}
        \begin{itemize}[noitemsep, leftmargin=*]
            #3
        \end{itemize}
        
        % Description (Optional)
        \ifstrempty{#4}{}{
            \vspace{0.3cm}
            {\noindent\bfseries\color{TextColor} \faIcon{pen}\ Descrizione:} #4
        }
        
        \vspace{0.5cm}
        \section*{Preparazione \faIcon{utensils}}
        \begin{enumerate}
            #5
        \end{enumerate}
    \end{minipage}%
    \hfill
    \begin{minipage}[t]{0.4\textwidth}
        \vspace{0pt} % Align top
        \includegraphics[width=\linewidth]{#7}
    \end{minipage}
    
    % Suggestion (Optional)
    \ifstrempty{#6}{}{
        \vfill
        \noindent
        {\color{SectionColor}\rule{\linewidth}{0.5pt}}\\[0.2cm]
        {\bfseries\itshape\color{TitleColor} \faIcon{lightbulb}\ Il Consiglio dello Chef:} #6
    }
    \par
}

% 3. Text Only Layout
% Usage: \recipeTextOnly{Title}{Servings/Time}{Ingredients}{Description}{Instructions}{Suggestion}
\newcommand{\recipeTextOnly}[6]{
    \clearpage
    {\sffamily\Huge\bfseries\color{TitleColor} #1}
    \par\vspace{0.5cm}
    {\large\bfseries\color{SectionColor} 
         \faIcon{clock}\ #2}
    \par\vspace{1cm}
    
    \section*{Ingredienti \faIcon{shopping-cart}}
    \begin{multicols}{2}
        \begin{itemize}[noitemsep]
            #3
        \end{itemize}
    \end{multicols}
    
    % Description (Optional)
    \ifstrempty{#4}{}{
        \vspace{0.3cm}
        {\noindent\bfseries\color{TextColor} \faIcon{pen}\ Descrizione:} #4
    }
    
    \vspace{0.5cm}
    \section*{Preparazione \faIcon{utensils}}
    \begin{enumerate}
        #5
    \end{enumerate}
    
    % Suggestion (Optional)
    \ifstrempty{#6}{}{
        \vfill
        \noindent
        {\color{SectionColor}\rule{\linewidth}{0.5pt}}\\[0.2cm]
        {\bfseries\itshape\color{TitleColor} \faIcon{lightbulb}\ Il Consiglio dello Chef:} #6
    }
}

% 4. Bottom Image Layout: Text Top, Image Bottom Full-Width
% Usage: \recipeBottomImage{Title}{Servings}{Time}{Ingredients}{Description}{Instructions}{Suggestion}{ImageFile}
\newcommand{\recipeBottomImage}[8]{
    \clearpage
    {\sffamily\Huge\bfseries\color{TitleColor} #1}
    \par\vspace{0.2cm}
    {\large\bfseries\color{SectionColor} 
         \faIcon{user-friends}\ #2 \quad \faIcon{clock}\ #3}
    \par\vspace{0.5cm}
    
    \section*{Ingredienti \faIcon{shopping-cart}}
    \begin{multicols}{2}
        \begin{itemize}[noitemsep]
            #4
        \end{itemize}
    \end{multicols}
    
    % Description (Optional)
    \ifstrempty{#5}{}{
        \vspace{0.3cm}
        {\noindent\bfseries\color{TextColor} \faIcon{pen}\ Descrizione:} #5
    }
    
    \vspace{0.5cm}
    \section*{Preparazione \faIcon{utensils}}
    \begin{enumerate}
        #6
    \end{enumerate}
    
    % Suggestion (Optional)
    \ifstrempty{#7}{}{
        \vspace{0.3cm}
        \noindent
        {\color{SectionColor}\rule{\linewidth}{1pt}}\\[0.2cm]
        {\bfseries\itshape\color{TitleColor} \faIcon{lightbulb}\ Il Consiglio dello Chef:} #7
    }

    \vfill
    \noindent
    % Image at the bottom, full text width
    \includegraphics[width=\linewidth, height=0.35\textheight, keepaspectratio=true]{#8}
}
