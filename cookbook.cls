\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cookbook}[2025/12/24 Custom Cookbook Class]

\LoadClass[11pt, openany]{book}

% Required Packages
\RequirePackage[a4paper, margin=3cm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\usepackage{microtype}
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Background commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command to set background for the CURRENT page only
\newcommand{\setBackground}[1]{
    \AddToShipoutPictureBG*{
        \begin{tikzpicture}[remember picture, overlay]
            \node[opacity=0.2, inner sep=0pt] at (current page.center) {
                \includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio=false]{#1}
            };
        \end{tikzpicture}
    }
}

% Command to create a page with just an image
\newcommand{\imagePage}[1]{
    \clearpage
    \thispagestyle{empty}
    \AddToShipoutPictureBG*{
        \begin{tikzpicture}[remember picture, overlay]
            \node[opacity=1, inner sep=0pt] at (current page.center) {
                \includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio=false]{#1}
            };
        \end{tikzpicture}
    }
    \null
    \clearpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chapter commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convenience command for Chapter with Background
% Usage: \chapterBg{Chapter Title}{BackgroundImage}
\newcommand{\chapterBg}[2]{
    \chapter{#1}
    \setBackground{#2}
}

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recipe commands
% Suggestion: use this with \setBackground
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newsavebox{\recimagebox}

% Helper for printing titles: no hyphenation, allow overflow
\newcommand{\printRecipeTitle}[1]{%
    \noindent
    \begin{minipage}{1.1\textwidth}% Allow 10% overflow into margin
        \raggedright % No justification
        \hyphenpenalty=10000 % No hyphenation
        \exhyphenpenalty=10000 % No explicit hyphenation
        \sffamily\Huge\bfseries\color{TitleColor} #1%
    \end{minipage}%
    \par\vspace{0.5cm}%
}

% 1. Text Only Layout
% Usage: \recipeTextOnly{Title}{Servings/Time}{Ingredients}{Description}{Instructions}{Suggestion}
\newcommand{\recipeTextOnly}[6]{
    \clearpage
    \clearpage
    \printRecipeTitle{#1}
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

% 2. Two Pages Layout: Text on Left, Full Image on Right
% This can be obtained combining \recipeTextOnly and \recipeImage

% 3. One Page Layout: Text and Image split
% Usage: \recipeOnePage{Title}{Servings/Time}{Ingredients}{Description}{Instructions}{Suggestion}{ImageFile}
\newcommand{\recipeOnePage}[7]{
    \clearpage
    \printRecipeTitle{#1}
    \par\vspace{0.2cm}
    {\large\bfseries\color{SectionColor} 
         \faIcon{clock}\ #2}
    \par\vspace{0.5cm}
    
    % Top Half: Two Columns Layout
    \noindent
    \begin{minipage}[t]{0.55\textwidth}
        \section*{Ingredienti \faIcon{shopping-cart}}
        \begin{itemize}[noitemsep, leftmargin=*]
            #3
        \end{itemize}
        
        % Description in left column
        \ifstrempty{#4}{}{
            \vspace{0.3cm}
            {\noindent\bfseries\color{TextColor} \faIcon{pen}\ Descrizione:} #4
        }
    \end{minipage}%
    \hfill
    \begin{minipage}[t]{0.4\textwidth}
        \vspace{0pt} % Align top
        \begin{center}
        \begin{tikzpicture}
            \node[
                draw=TitleColor, 
                line width=1.5pt, 
                rounded corners=15pt, 
                inner sep=0pt,
                path picture={
                    \node at (path picture bounding box.center) {
                        \includegraphics[width=\linewidth, keepaspectratio]{#7}
                    };
                }
            ] {\phantom{\includegraphics[width=\linewidth]{#7}}};
        \end{tikzpicture}
        \end{center}
    \end{minipage}
    
    \vspace{0.5cm}
    
    % Bottom Half: Full Width Preparation
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
    \par
}


% 4. Bottom Image Layout: Text Top, Image Bottom Full-Width
% Usage: \recipeBottomImage{Title}{Servings}{Time}{Ingredients}{Description}{Instructions}{Suggestion}{ImageFile}
\newcommand{\recipeBottomImage}[7]{
    \clearpage
    \printRecipeTitle{#1}
    \par\vspace{0.2cm}
    {\large\bfseries\color{SectionColor} 
         \faIcon{clock}\ #2}
    \par\vspace{0.5cm}
    
    \section*{Ingredienti \faIcon{shopping-cart}}
    \begin{multicols}{2}
        \begin{itemize}[noitemsep]
            #3
        \end{itemize}
    \end{multicols}
    
    % Description (Optional)
    \ifstrempty{#5}{}{
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
        \vspace{0.3cm}
        \noindent
        {\color{SectionColor}\rule{\linewidth}{1pt}}\\[0.2cm]
        {\bfseries\itshape\color{TitleColor} \faIcon{lightbulb}\ Il Consiglio dello Chef:} #6
    }
    \par

    % Image as a larger bottom banner (half page) - SMART COVER CENTER
    \AddToShipoutPictureBG*{
        \begin{tikzpicture}[remember picture, overlay]
            \node[opacity=0.45, inner sep=0pt, anchor=south, minimum width=\paperwidth, minimum height=0.4\paperheight, path picture={
                % Smart Cover Logic:
                % 1. Save image scaled to width
                \sbox{\recimagebox}{\includegraphics[width=\paperwidth, keepaspectratio]{#7}}%
                % 2. Check height
                \ifdim\ht\recimagebox<0.4\paperheight
                    % Too short? Scale by height (width will be > paperwidth) -> Cover
                    \node[anchor=center] at (path picture bounding box.center) {
                        \includegraphics[height=0.4\paperheight, keepaspectratio]{#7}
                    };
                \else
                    % Tall enough? Scale by width -> Cover
                    \node[anchor=center] at (path picture bounding box.center) {
                        \usebox{\recimagebox}
                    };
                \fi
            }] at (current page.south) {};
        \end{tikzpicture}
    }
}
