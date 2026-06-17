/*
  The Yambeji Chronicles — Book One: The Current's Edge
  An "immersive artifact" microsite: a liquid river-shader hero, a Zero-UI
  compass nav, a stacking trilogy archive, and a sigil-discovery altar.
  Uses TailwindCSS, Framer Motion, Lucide React icons.
*/

import React, { useEffect, useRef, useState } from 'react';
import { motion } from 'framer-motion';
import { Mail, ShoppingCart, ArrowRight } from 'lucide-react';

const BOOK = {
  title: "The Current's Edge",
  trilogyTitle: 'The Yambeji Chronicles',
  subtitle: "A luminous, mythic YA novel where rivers hold memory and power flows through bloodlines.",
  cover: null,
  buyLink: '#',
  excerpt: `"The river spoke in frequencies she couldn't name but somehow understood.
Amara pressed her palms against the smooth stone of the riverbank, feeling
the vibration travel up through her bones. This was the inheritance her
grandmother had tried to prepare her for—not just the land, but the
responsibility that came with being able to hear what the water remembered.

'Every current tells a story,' her grandmother had said. 'But not every
story is meant to be changed.'

Now, with the developers' machines growing louder each day and the river's
voice growing more urgent, Amara understood that some stories demanded to
be rewritten—even if the cost was everything she thought she knew about home."`,
  author: {
    name: 'Musole Kambinda',
    bio: 'Writer. Explorer of environmental justice and cultural preservation. Telling stories where land, memory, and identity collide.',
    photo: null,
  },
};

const TRILOGY = [
  {
    id: 'book-1',
    label: 'Book One',
    title: "The Current's Edge",
    theme: 'weathered',
    blurb: 'A sun-bleached inheritance. Amara learns the river remembers everything.',
  },
  {
    id: 'book-2',
    label: 'Book Two',
    title: 'The Drowned Names',
    theme: 'underwater',
    blurb: 'Beneath the surface, the Yambeji keeps the names the land forgot.',
  },
  {
    id: 'book-3',
    label: 'Book Three',
    title: 'Ley of Nyami Nyami',
    theme: 'obsidian',
    blurb: 'The current chooses its final vessel. The prophecy closes the circle.',
  },
];

const SIGILS = [
  {
    id: 'inheritance',
    label: 'Inheritance',
    text: 'Amara inherits more than land — she receives ancestral knowledge and the burden of choice.',
    icon: (
      <svg viewBox="0 0 48 48" fill="none">
        <path d="M24 6 L42 40 L6 40 Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
        <circle cx="24" cy="30" r="3" stroke="currentColor" strokeWidth="2" />
      </svg>
    ),
  },
  {
    id: 'displacement',
    label: 'Displacement',
    text: 'When home becomes contested ground, every decision carries the risk of losing what matters most.',
    icon: (
      <svg viewBox="0 0 48 48" fill="none">
        <rect x="8" y="8" width="24" height="24" stroke="currentColor" strokeWidth="2" />
        <rect x="16" y="16" width="24" height="24" stroke="currentColor" strokeWidth="2" />
      </svg>
    ),
  },
  {
    id: 'language',
    label: 'Language',
    text: 'The river speaks in frequencies older than words, teaching those who learn to listen.',
    icon: (
      <svg viewBox="0 0 48 48" fill="none">
        <path
          d="M24 6 C30 6 34 10 34 16 C34 22 28 24 24 24 C20 24 16 26 16 31 C16 36 20 40 26 40"
          stroke="currentColor"
          strokeWidth="2"
          strokeLinecap="round"
        />
      </svg>
    ),
  },
  {
    id: 'current',
    label: 'The Current',
    text: 'Nyami Nyami moves through every bloodline that touches the Yambeji — power is a current, not a possession.',
    icon: (
      <svg viewBox="0 0 48 48" fill="none">
        <path d="M4 16 C12 10 18 22 26 16 C34 10 40 22 44 16" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        <path d="M4 26 C12 20 18 32 26 26 C34 20 40 32 44 26" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        <path d="M4 36 C12 30 18 42 26 36 C34 30 40 42 44 36" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
      </svg>
    ),
  },
];

const COMPASS_DIRECTIONS = [
  { id: 'top', label: 'Story', angle: 0, target: 'hero' },
  { id: 'right', label: 'World', angle: 90, target: 'trilogy' },
  { id: 'bottom', label: 'Author', angle: 180, target: 'signup' },
  { id: 'left', label: 'Voice', angle: 270, target: 'excerpt' },
];

/* --- Liquid canvas: mouse-reactive metaball "river" --- */
function LiquidCanvas() {
  const canvasRef = useRef(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    const ctx = canvas.getContext('2d');
    let raf;
    let width = (canvas.width = canvas.offsetWidth);
    let height = (canvas.height = canvas.offsetHeight);

    const mouse = { x: width / 2, y: height / 2 };
    let lastScrollY = window.scrollY;
    let turbulence = 0;

    const blobs = Array.from({ length: 7 }, (_, i) => ({
      x: Math.random() * width,
      y: Math.random() * height,
      vx: (Math.random() - 0.5) * 0.4,
      vy: (Math.random() - 0.5) * 0.4,
      r: 70 + Math.random() * 90,
      hue: i % 2 === 0 ? 'rgba(26,107,122,0.9)' : 'rgba(78,205,196,0.7)',
    }));

    function handleResize() {
      width = canvas.width = canvas.offsetWidth;
      height = canvas.height = canvas.offsetHeight;
    }

    function handleMouseMove(e) {
      const rect = canvas.getBoundingClientRect();
      mouse.x = e.clientX - rect.left;
      mouse.y = e.clientY - rect.top;
    }

    function handleScroll() {
      turbulence = Math.min(Math.abs(window.scrollY - lastScrollY), 40);
      lastScrollY = window.scrollY;
    }

    function tick() {
      ctx.fillStyle = '#070a0f';
      ctx.fillRect(0, 0, width, height);

      blobs.forEach((b) => {
        const dx = mouse.x - b.x;
        const dy = mouse.y - b.y;
        const dist = Math.hypot(dx, dy) || 1;
        const pull = Math.min(60 / dist, 0.6);
        b.vx += (dx / dist) * pull * 0.02;
        b.vy += (dy / dist) * pull * 0.02;
        b.vx += (Math.random() - 0.5) * 0.02 * (1 + turbulence * 0.05);
        b.vy += (Math.random() - 0.5) * 0.02 * (1 + turbulence * 0.05);
        b.vx *= 0.96;
        b.vy *= 0.96;
        b.x += b.vx * (1 + turbulence * 0.1);
        b.y += b.vy * (1 + turbulence * 0.1);

        if (b.x < -b.r) b.x = width + b.r;
        if (b.x > width + b.r) b.x = -b.r;
        if (b.y < -b.r) b.y = height + b.r;
        if (b.y > height + b.r) b.y = -b.r;

        const grad = ctx.createRadialGradient(b.x, b.y, 0, b.x, b.y, b.r);
        grad.addColorStop(0, b.hue);
        grad.addColorStop(1, 'rgba(7,10,15,0)');
        ctx.fillStyle = grad;
        ctx.beginPath();
        ctx.arc(b.x, b.y, b.r, 0, Math.PI * 2);
        ctx.fill();
      });

      turbulence *= 0.92;
      raf = requestAnimationFrame(tick);
    }

    window.addEventListener('resize', handleResize);
    window.addEventListener('mousemove', handleMouseMove);
    window.addEventListener('scroll', handleScroll);
    tick();

    return () => {
      cancelAnimationFrame(raf);
      window.removeEventListener('resize', handleResize);
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  return <canvas id="liquid-canvas" ref={canvasRef} />;
}

/* --- Zero-UI compass navigation --- */
function CompassNav({ onNavigate }) {
  const [angle, setAngle] = useState(0);

  useEffect(() => {
    function handleMouseMove(e) {
      const cx = window.innerWidth - 70;
      const cy = window.innerHeight - 70;
      const a = (Math.atan2(e.clientY - cy, e.clientX - cx) * 180) / Math.PI;
      setAngle(a + 90);
    }
    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  }, []);

  const radius = 38;
  return (
    <nav className="compass-nav" aria-label="Compass navigation">
      <div className="compass-ring" />
      <div className="compass-needle" style={{ transform: `rotate(${angle}deg)` }} />
      <div className="compass-center" />
      {COMPASS_DIRECTIONS.map((d) => {
        const rad = ((d.angle - 90) * Math.PI) / 180;
        const x = 46 + radius * Math.cos(rad);
        const y = 46 + radius * Math.sin(rad);
        return (
          <button
            key={d.id}
            className="compass-label"
            style={{ left: x, top: y, transform: 'translate(-50%, -50%)' }}
            onClick={() => onNavigate(d.target)}
          >
            {d.label}
          </button>
        );
      })}
    </nav>
  );
}

/* --- Trilogy archive: stacking cards --- */
function TrilogyStack() {
  const [activeIndex, setActiveIndex] = useState(0);

  return (
    <div className="trilogy-stack">
      {TRILOGY.map((book, i) => {
        const offset = i - activeIndex;
        const isActive = i === activeIndex;
        return (
          <motion.div
            key={book.id}
            className={`trilogy-card ${book.theme}`}
            onClick={() => setActiveIndex(i)}
            style={{ zIndex: TRILOGY.length - Math.abs(offset) }}
            animate={{
              x: offset * 36,
              y: Math.abs(offset) * 14,
              rotate: offset * 3,
              scale: isActive ? 1 : 0.94,
              opacity: Math.abs(offset) > 2 ? 0 : 1,
            }}
            transition={{ type: 'spring', stiffness: 180, damping: 22 }}
          >
            <div className="text-xs uppercase tracking-widest text-[var(--ley-line)]">{book.label}</div>
            <h3 className="font-fraunces text-2xl mt-2 text-[var(--warm)]">{book.title}</h3>
            {isActive && (
              <motion.p
                initial={{ opacity: 0, y: 8 }}
                animate={{ opacity: 1, y: 0 }}
                className="mt-3 text-sm text-[var(--warm-faint)] max-w-sm"
              >
                {book.blurb}
              </motion.p>
            )}
          </motion.div>
        );
      })}
    </div>
  );
}

/* --- Sigil discovery altar --- */
function SigilAltar() {
  const [activeId, setActiveId] = useState(null);
  const active = SIGILS.find((s) => s.id === activeId);

  return (
    <div>
      <div className="sigil-altar">
        {SIGILS.map((s) => (
          <div
            key={s.id}
            className={`sigil-tile ${activeId === s.id ? 'active' : ''}`}
            onClick={() => setActiveId(activeId === s.id ? null : s.id)}
            role="button"
            tabIndex={0}
          >
            <div className="sigil-bleed" />
            {s.icon}
          </div>
        ))}
      </div>
      <motion.div
        key={active ? active.id : 'none'}
        initial={{ opacity: 0, y: 8 }}
        animate={{ opacity: 1, y: 0 }}
        className="mt-6 min-h-[3rem] text-[var(--warm-faint)] max-w-2xl"
      >
        {active ? (
          <>
            <span className="text-[var(--ley-line)] font-medium">{active.label}. </span>
            {active.text}
          </>
        ) : (
          'Touch a sigil to unearth what it remembers.'
        )}
      </motion.div>
    </div>
  );
}

export default function BookMicrosite() {
  const ref = useRef(null);

  useEffect(() => {
    const handleScroll = () => {
      const revealElements = document.querySelectorAll('.scroll-reveal, .book-scroll-reveal');
      revealElements.forEach((element) => {
        const elementTop = element.getBoundingClientRect().top;
        const elementVisible = 150;
        if (elementTop < window.innerHeight - elementVisible) {
          element.classList.add('revealed');
        }
      });
    };

    window.addEventListener('scroll', handleScroll);
    handleScroll();
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const [showExcerpt, setShowExcerpt] = useState(false);
  const [mail, setMail] = useState('');
  const [saved, setSaved] = useState(false);
  const [isExpanded, setIsExpanded] = useState(false);
  const [navSolid, setNavSolid] = useState(false);
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTrack, setCurrentTrack] = useState(0);
  const [audioElement, setAudioElement] = useState(null);
  const [riddleRevealed, setRiddleRevealed] = useState(false);

  const audioTracks = [
    {
      id: 'amara-preview',
      title: 'Amara Preview',
      duration: '2:34',
      description: "Experience Amara's world in her own voice",
      audioUrl: 'https://drive.google.com/uc?export=download&id=141SpfNCtA0EwsomO6mIx_zXAIbx9p2d6',
      waveform: [0.4, 0.8, 0.6, 0.9, 0.7, 0.5, 0.8, 0.6, 0.4, 0.9, 0.7, 0.5],
      isLive: true,
    },
    {
      id: 'river-whispers',
      title: 'River Whispers',
      duration: '3:12',
      description: 'The river speaks its ancient language',
      audioUrl: null,
      waveform: [0.3, 0.7, 0.4, 0.8, 0.6, 0.9, 0.5, 0.7, 0.3, 0.6, 0.8, 0.4],
      isLive: false,
    },
    {
      id: 'dreaming-grove',
      title: 'The Dreaming Grove',
      duration: '4:12',
      description: 'Where memories take root',
      audioUrl: null,
      waveform: [0.5, 0.3, 0.8, 0.4, 0.7, 0.6, 0.9, 0.5, 0.4, 0.8, 0.6, 0.3],
      isLive: false,
    },
  ];

  useEffect(() => {
    const onScroll = () => setNavSolid(window.scrollY > 60);
    onScroll();
    window.addEventListener('scroll', onScroll);
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  useEffect(() => {
    const audio = new Audio();
    audio.addEventListener('ended', () => setIsPlaying(false));
    audio.addEventListener('pause', () => setIsPlaying(false));
    audio.addEventListener('play', () => setIsPlaying(true));
    audio.addEventListener('error', (e) => {
      console.log('Audio error:', e);
      setIsPlaying(false);
    });
    setAudioElement(audio);

    return () => {
      if (audio) {
        audio.pause();
        audio.src = '';
      }
    };
  }, []);

  function handleMailSubmit(e) {
    e.preventDefault();
    if (!mail || !mail.includes('@')) return alert('Enter a real email');
    const list = JSON.parse(localStorage.getItem('book_mailing_list') || '[]');
    list.unshift({ email: mail, at: new Date().toISOString() });
    localStorage.setItem('book_mailing_list', JSON.stringify(list));
    setSaved(true);
    setRiddleRevealed(true);
    setMail('');
    setTimeout(() => setSaved(false), 2500);
  }

  function handlePlayPause(track = null) {
    if (!audioElement) return;
    const targetTrack = track || audioTracks[currentTrack];
    if (!targetTrack.audioUrl) return;

    if (track && track.id !== audioTracks[currentTrack].id) {
      setCurrentTrack(audioTracks.findIndex((t) => t.id === track.id));
    }

    if (isPlaying && audioElement.src === targetTrack.audioUrl) {
      audioElement.pause();
    } else {
      if (audioElement.src !== targetTrack.audioUrl) {
        audioElement.src = targetTrack.audioUrl;
      }
      audioElement.play().catch(console.error);
    }
  }

  function scrollToId(id) {
    const el = document.getElementById(id);
    if (!el) return;
    el.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }

  const reveal = {
    hidden: { opacity: 0, y: 30 },
    show: { opacity: 1, y: 0 },
  };

  return (
    <div className="yambeji-root min-h-screen font-inter" ref={ref}>
      {/* COMPASS NAV (Zero-UI) */}
      <CompassNav onNavigate={scrollToId} />

      {/* MINIMAL TOP NAV */}
      <nav className={`fixed inset-x-0 top-4 z-40 transition-all ${navSolid ? 'backdrop-blur bg-black/40' : ''}`}>
        <div className="max-w-6xl mx-auto px-6 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-full bg-gradient-to-br from-[var(--river-teal)] to-[var(--ley-line)] flex items-center justify-center text-[var(--river-bed)] font-bold text-sm">YC</div>
            <div className="text-sm font-medium text-[var(--warm)] tracking-wide">{BOOK.trilogyTitle}</div>
          </div>
          <a href={BOOK.buyLink} className="inline-flex items-center gap-2 rounded-lg px-3 py-2 bg-gradient-to-r from-[var(--river-teal)] to-[var(--ley-line)] text-[var(--river-bed)] text-sm font-medium hover:opacity-90 transition-all">
            Buy <ShoppingCart size={14} />
          </a>
        </div>
      </nav>

      {/* FLOATING AUDIO PLAYER */}
      <motion.div
        initial={{ opacity: 0, x: -50 }}
        animate={{ opacity: 1, x: 0 }}
        transition={{ delay: 1 }}
        className="fixed bottom-6 left-6 z-40"
      >
        <div
          className={`dynamic-island cursor-pointer transition-all duration-500 ease-out ${isExpanded ? 'expanded' : ''}`}
          style={{
            width: isExpanded ? '400px' : '200px',
            height: isExpanded ? '320px' : '60px',
            transform: isExpanded ? 'scale(1.02)' : 'scale(1)',
            borderRadius: isExpanded ? '20px' : '30px',
          }}
          onClick={() => setIsExpanded(!isExpanded)}
        >
          {!isExpanded ? (
            <div className="h-full flex items-center justify-between px-4">
              <div className="flex items-center space-x-3">
                <motion.button
                  onClick={(e) => {
                    e.stopPropagation();
                    handlePlayPause();
                  }}
                  className="genie-button w-8 h-8 rounded-full flex items-center justify-center text-white text-sm relative overflow-hidden"
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.98 }}
                  style={{
                    boxShadow: isPlaying
                      ? '0 0 20px rgba(78, 205, 196, 0.6), 0 0 40px rgba(78, 205, 196, 0.3)'
                      : '0 0 10px rgba(78, 205, 196, 0.3)',
                  }}
                >
                  {isPlaying && (
                    <motion.div
                      className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent"
                      animate={{ x: ['-100%', '100%'] }}
                      transition={{ duration: 2, repeat: Infinity, ease: 'linear' }}
                    />
                  )}
                  <span className="relative z-10 text-sm">{isPlaying ? '⏸️' : '▶️'}</span>
                </motion.button>
                <div>
                  <div className="text-sm font-medium text-white">{audioTracks[currentTrack].title}</div>
                  <div className="text-xs text-[var(--ley-line)]">{audioTracks[currentTrack].duration}</div>
                </div>
              </div>
              <div className="text-[var(--ley-line)] text-xs">🎧</div>
            </div>
          ) : (
            <div className="p-6 h-full">
              <div className="text-center mb-4">
                <h3 className="text-white font-bold text-lg glow-text">Audio Samples</h3>
                <p className="text-[var(--ley-line)] text-sm">Experience Amara's world</p>
              </div>
              <div className="space-y-3 max-h-60 overflow-y-auto">
                {audioTracks.map((sample) => (
                  <div
                    key={sample.id}
                    className="woven-band p-3 rounded-lg cursor-pointer hover:bg-[rgba(78,205,196,0.1)] transition-colors"
                    onClick={(e) => {
                      e.stopPropagation();
                      handlePlayPause(sample);
                    }}
                  >
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="text-white text-sm font-medium flex items-center gap-2">
                          {sample.title}
                          {sample.isLive && <span className="text-xs bg-[var(--river-teal)] px-2 py-1 rounded-full">🎙️ LIVE</span>}
                        </div>
                        <div className="text-gray-300 text-xs">{sample.description}</div>
                      </div>
                      <div className="text-[var(--ley-line)] text-xs ml-2">{sample.isLive ? '🎧' : sample.duration}</div>
                    </div>
                    <div className="flex items-end space-x-1 mt-2">
                      {sample.waveform.map((height, i) => (
                        <div
                          key={i}
                          className="waveform-bar"
                          style={{
                            height: `${height * 30}px`,
                            animation:
                              audioTracks[currentTrack].id === sample.id && isPlaying
                                ? `pulseWave 0.5s ease-in-out infinite ${i * 0.1}s`
                                : 'none',
                          }}
                        />
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </motion.div>

      {/* HERO — The River's Flow */}
      <section id="hero" className="river-section">
        <LiquidCanvas />
        <div className="hero-overlay px-6">
          <span className="sigil-loader">▽</span>
          <motion.h1
            initial={{ opacity: 0, y: -18 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.05 }}
            className="text-2xl md:text-3xl uppercase tracking-[0.3em] text-[var(--warm-faint)]"
          >
            {BOOK.trilogyTitle}
          </motion.h1>
          <motion.h2
            initial={{ opacity: 0, y: -18 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.15 }}
            className="font-fraunces text-5xl md:text-7xl mt-3 text-[var(--warm)]"
          >
            {BOOK.title}
          </motion.h2>
          <motion.p
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.3 }}
            className="mt-5 text-base md:text-lg text-[var(--warm-faint)] max-w-xl mx-auto"
          >
            {BOOK.subtitle}
          </motion.p>
          <div className="mt-8 flex flex-wrap gap-3 justify-center">
            <button onClick={() => scrollToId('buy')} className="button-primary inline-flex items-center gap-2 px-5 py-3 rounded-lg font-semibold">
              Buy the Book <ArrowRight size={16} />
            </button>
            <button onClick={() => setShowExcerpt(true)} className="px-4 py-3 rounded-lg border border-[rgba(78,205,196,0.4)] text-[var(--warm)] hover:bg-[rgba(78,205,196,0.1)] transition-all">
              Read an Excerpt
            </button>
          </div>
          <div className="scroll-prompt">Follow the Current ▼</div>
        </div>
      </section>

      {/* TRILOGY ARCHIVE */}
      <section id="trilogy" className="py-24">
        <div className="max-w-3xl mx-auto px-6 text-center">
          <h2 className="font-fraunces text-3xl text-[var(--warm)]">The Trilogy Archive</h2>
          <p className="mt-3 text-[var(--warm-faint)]">Three chronicles, one current. Pull a chronicle from the stack.</p>
        </div>
        <div className="max-w-md mx-auto mt-12 px-6">
          <TrilogyStack />
        </div>
      </section>

      {/* SIGIL ALTAR (About) */}
      <section id="about" className="py-20">
        <div className="max-w-4xl mx-auto px-6">
          <motion.div initial="hidden" whileInView="show" viewport={{ once: true }} variants={{ show: { transition: { staggerChildren: 0.14 } } }}>
            <motion.h2 variants={reveal} className="text-3xl font-fraunces text-[var(--warm)]">
              The Digital Altar
            </motion.h2>
            <motion.p variants={reveal} className="mt-4 text-[var(--warm-faint)] max-w-2xl">
              Set in a world where rivers hold memory and power flows through bloodlines,{' '}
              <em className="text-[var(--ley-line)]">The Current's Edge</em> follows Amara as she navigates the
              intersection of tradition and survival, discovering that some inheritances demand everything.
            </motion.p>
            <motion.div variants={reveal} className="mt-10">
              <SigilAltar />
            </motion.div>
          </motion.div>
        </div>
      </section>

      {/* EXCERPT */}
      <section id="excerpt" className="py-20 bg-[rgba(255,255,255,0.02)]">
        <div className="max-w-4xl mx-auto px-6">
          <motion.div initial="hidden" whileInView="show" viewport={{ once: true }} className="space-y-4">
            <motion.h3 variants={reveal} className="text-2xl font-fraunces text-[var(--warm)]">
              An Excerpt
            </motion.h3>
            <motion.div variants={reveal} className="prose max-w-none text-[var(--warm-faint)] whitespace-pre-line">
              {BOOK.excerpt}
            </motion.div>
            <div className="mt-4">
              <button onClick={() => setShowExcerpt(true)} className="px-4 py-2 rounded border border-[rgba(78,205,196,0.3)] text-[var(--warm)] hover:bg-[rgba(78,205,196,0.1)] transition-all">
                Read more
              </button>
            </div>
          </motion.div>
        </div>
      </section>

      {/* REVIEWS */}
      <section className="py-20">
        <div className="max-w-6xl mx-auto px-6">
          <motion.h4 initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} className="text-xl font-fraunces text-[var(--warm)]">
            Early Praise
          </motion.h4>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} className="mt-6 grid md:grid-cols-3 gap-6">
            {[
              "A mesmerizing blend of magical realism and environmental urgency. The Current's Edge flows with the power of tradition and the necessity of change.",
              "Amara's journey through inheritance and identity resonates with profound truth. This book will stay with you like the sound of running water.",
              'A powerful meditation on land, legacy, and the languages we inherit. Essential reading for our time.',
            ].map((q, i) => (
              <div key={i} className="bg-[rgba(255,255,255,0.03)] border border-[rgba(78,205,196,0.15)] p-6 rounded-xl">
                <div className="italic text-[var(--warm-faint)]">"{q}"</div>
                <div className="mt-4 text-xs text-[var(--ley-line)]">— Advance reader</div>
              </div>
            ))}
          </motion.div>
        </div>
      </section>

      {/* MESSENGER FROM THE RIVER / BUY+SIGNUP */}
      <section id="buy" className="py-20">
        <div className="max-w-4xl mx-auto px-6 grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
          <div>
            <motion.h2 initial={{ opacity: 0, x: -20 }} whileInView={{ opacity: 1, x: 0 }} className="text-3xl font-fraunces text-[var(--warm)]">
              Get a copy
            </motion.h2>
            <motion.p initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} className="mt-3 text-[var(--warm-faint)]">
              Available in paperback, ebook, and audiobook. Preorder opens soon — sign up to receive a prophecy from the river.
            </motion.p>
            <div className="mt-6 flex gap-3">
              <a href={BOOK.buyLink} className="px-5 py-3 rounded-lg bg-gradient-to-r from-[var(--river-teal)] to-[var(--ley-line)] text-[var(--river-bed)] font-semibold inline-flex items-center gap-2 hover:opacity-90 transition-all">
                Buy now <ShoppingCart size={14} />
              </a>
            </div>
          </div>
          <motion.form
            onSubmit={handleMailSubmit}
            initial={{ opacity: 0, x: 20 }}
            whileInView={{ opacity: 1, x: 0 }}
            className="messenger-widget p-6"
          >
            <div className="relative z-10">
              <div className="text-sm font-medium text-[var(--warm)]">The Messenger from the River</div>
              <p className="text-xs text-[var(--warm-faint)] mt-1">
                Give your name to the current, and receive a Zambezi prophecy in return.
              </p>
              <div className="mt-3 flex gap-2">
                <input
                  value={mail}
                  onChange={(e) => setMail(e.target.value)}
                  placeholder="you@domain.com"
                  className="flex-1 border border-[rgba(78,205,196,0.3)] rounded px-3 py-2 bg-black/30 text-[var(--warm)] placeholder-[var(--warm-faint)] focus:border-[var(--ley-line)] focus:outline-none"
                />
                <button type="submit" className="px-3 py-2 rounded bg-gradient-to-r from-[var(--river-teal)] to-[var(--ley-line)] text-[var(--river-bed)] font-medium hover:opacity-90 transition-all">
                  <Mail size={14} />
                </button>
              </div>
              {saved && riddleRevealed && (
                <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="mt-3 text-sm text-[var(--ley-line)] italic">
                  "What the current takes, it remembers. What it gives, it never forgets." — Nyami Nyami
                </motion.div>
              )}
            </div>
          </motion.form>
        </div>
      </section>

      {/* AUTHOR */}
      <section className="py-20" id="signup">
        <div className="max-w-6xl mx-auto px-6 grid md:grid-cols-3 gap-6 items-center">
          <div className="col-span-1">
            {BOOK.author.photo ? (
              <img src={BOOK.author.photo} alt={BOOK.author.name} className="w-40 h-40 rounded-full object-cover border-2 border-[var(--ley-line)]/40" />
            ) : (
              <div className="w-40 h-40 rounded-full bg-[rgba(78,205,196,0.08)] border-2 border-[var(--ley-line)]/40 flex items-center justify-center text-4xl text-[var(--ley-line)]">📚</div>
            )}
          </div>
          <div className="col-span-2">
            <h5 className="text-xl font-fraunces text-[var(--warm)]">{BOOK.author.name}</h5>
            <p className="mt-2 text-[var(--warm-faint)]">{BOOK.author.bio}</p>
            <div className="mt-4 flex gap-3">
              <a className="px-4 py-2 rounded border border-[rgba(78,205,196,0.3)] text-[var(--ley-line)] hover:bg-[rgba(78,205,196,0.1)] transition-all cursor-pointer">Contact</a>
              <a className="px-4 py-2 rounded border border-[rgba(255,255,255,0.1)] text-[var(--warm-faint)] hover:bg-white/5 transition-all cursor-pointer">Events</a>
            </div>
          </div>
        </div>
      </section>

      {/* FOOTER */}
      <footer className="py-8 bg-black/40 border-t border-white/5">
        <div className="max-w-6xl mx-auto px-6 text-sm text-[var(--warm-faint)] flex justify-between items-center">
          <div>© {new Date().getFullYear()} {BOOK.author.name}</div>
          <div className="flex gap-4">
            <a className="hover:text-[var(--ley-line)] transition-colors cursor-pointer">Privacy</a>
            <a className="hover:text-[var(--ley-line)] transition-colors cursor-pointer">Terms</a>
          </div>
        </div>
      </footer>

      {/* Excerpt modal */}
      {showExcerpt && (
        <div className="fixed inset-0 z-60 flex items-center justify-center bg-black/70 p-6">
          <motion.div initial={{ scale: 0.9, opacity: 0 }} animate={{ scale: 1, opacity: 1 }} className="max-w-3xl w-full bg-[var(--river-surface)] border border-[rgba(78,205,196,0.2)] rounded-xl p-6 shadow-2xl">
            <div className="flex items-start justify-between">
              <h4 className="text-lg font-fraunces text-[var(--warm)]">Excerpt — {BOOK.title}</h4>
              <button onClick={() => setShowExcerpt(false)} className="text-[var(--warm-faint)] hover:text-[var(--warm)] transition-colors">
                Close
              </button>
            </div>
            <div className="mt-4 prose whitespace-pre-line text-[var(--warm-faint)]">
              <p>{BOOK.excerpt}</p>
              <p>— continued —</p>
            </div>
            <div className="mt-6 flex justify-end">
              <a href={BOOK.buyLink} className="px-4 py-2 rounded bg-gradient-to-r from-[var(--river-teal)] to-[var(--ley-line)] text-[var(--river-bed)] font-medium hover:opacity-90 transition-all">
                Buy the Book
              </a>
            </div>
          </motion.div>
        </div>
      )}
    </div>
  );
}
