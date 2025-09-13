/*
  The Current's Edge — Single-file React landing page
  Clone of pasteapp.io, customized for your YA Neo-African Futuristic Book.
  - Uses TailwindCSS, Framer Motion, Lucide React icons.
  - Drop into Next.js/CRA/Vite.
  - Replace placeholder info with your own.
  - Mailing list + purchase are stubbed with localStorage.
  - Animations and structure closely follow the pasteapp.io style.
  Install:
    npm install framer-motion lucide-react
*/

import React, { useEffect, useRef, useState } from 'react';
import { motion, useScroll, useTransform } from 'framer-motion';
import { Mail, ShoppingCart, ArrowRight } from 'lucide-react';

export default function BookMicrosite() {
  // --- Replace these with your real content ---
  const BOOK = {
    title: "The Current's Edge",
    subtitle: "A luminous, mythic YA novel where rivers hold memory and power flows through bloodlines.",
    cover: null, // TODO: Replace with cover image URL or import
    buyLink: "#", // TODO: Replace with real buy/preorder link
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
      name: 'Musole Kambinda', // TODO: Replace with your name
      bio: "Writer. Explorer of environmental justice and cultural preservation. Telling stories where land, memory, and identity collide.",
      photo: null, // TODO: Replace with author photo URL or import
    },
  };

  // --- scroll / parallax ---
  const ref = useRef(null);
  const { scrollY } = useScroll();
  const y1 = useTransform(scrollY, [0, 600], [0, -60]);
  const y2 = useTransform(scrollY, [0, 800], [0, -120]);

  // --- local state ---
  const [showExcerpt, setShowExcerpt] = useState(false);
  const [mail, setMail] = useState('');
  const [saved, setSaved] = useState(false);
  const [navSolid, setNavSolid] = useState(false);
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTrack, setCurrentTrack] = useState(0);
  
  // Audio tracks data
  const audioTracks = [
    {
      id: 'amara-preview',
      title: 'Amara Preview',
      duration: '2:34',
      description: 'Experience Amara\'s world in her own voice',
      audioUrl: 'https://docs.google.com/uc?export=download&id=141SpfNCtA0EwsomO6mIx_zXAIbx9p2d6'
    },
    {
      id: 'river-whispers',
      title: 'River Whispers',
      duration: '3:12',
      description: 'The river speaks its ancient language',
      audioUrl: null
    }
  ];

  useEffect(() => {
    const onScroll = () => setNavSolid(window.scrollY > 60);
    onScroll();
    window.addEventListener('scroll', onScroll);
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  function handleMailSubmit(e) {
    e.preventDefault();
    if (!mail || !mail.includes('@')) return alert('Enter a real email');
    // stub: save to localStorage
    const list = JSON.parse(localStorage.getItem('book_mailing_list') || '[]');
    list.unshift({ email: mail, at: new Date().toISOString() });
    localStorage.setItem('book_mailing_list', JSON.stringify(list));
    setSaved(true);
    setMail('');
    setTimeout(() => setSaved(false), 2500);
  }

  function handlePlayPause() {
    const track = audioTracks[currentTrack];
    if (!track.audioUrl) return;
    
    const audio = new Audio(track.audioUrl);
    if (isPlaying) {
      audio.pause();
      setIsPlaying(false);
    } else {
      audio.play().catch(console.error);
      setIsPlaying(true);
      audio.addEventListener('ended', () => setIsPlaying(false));
    }
  }

  // simple smooth anchor scroller
  function scrollToId(id) {
    const el = document.getElementById(id);
    if (!el) return;
    el.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }

  // reveal animation variants
  const reveal = {
    hidden: { opacity: 0, y: 30 },
    show: { opacity: 1, y: 0 },
  };

  return (
    <div className="min-h-screen font-sans bg-gradient-to-b from-slate-900 via-slate-800 to-slate-900 text-white" ref={ref}>
      {/* NAVBAR */}
      <nav className={`fixed inset-x-0 top-4 z-50 transition-all ${navSolid ? 'backdrop-blur bg-slate-900/80 shadow-lg shadow-emerald-500/10' : ''}`}>
        <div className="max-w-6xl mx-auto px-6 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-400 to-cyan-500 flex items-center justify-center text-white font-bold shadow-lg shadow-emerald-500/30">CE</div>
            <div className="text-sm font-medium text-white">{BOOK.title}</div>
          </div>
          <div className="flex items-center gap-4">
            <button onClick={() => scrollToId('about')} className="text-sm text-gray-300 hover:text-emerald-400 transition-colors">About</button>
            <button onClick={() => scrollToId('excerpt')} className="text-sm text-gray-300 hover:text-emerald-400 transition-colors">Excerpt</button>
            <button onClick={() => scrollToId('buy')} className="text-sm text-gray-300 hover:text-emerald-400 transition-colors">Buy</button>
            <a href={BOOK.buyLink} className="ml-2 inline-flex items-center gap-2 rounded-lg px-3 py-2 bg-gradient-to-r from-emerald-600 to-cyan-600 text-white text-sm hover:from-emerald-700 hover:to-cyan-700 transition-all shadow-lg shadow-emerald-500/25">Buy <ShoppingCart size={14} /></a>
          </div>
        </div>
      </nav>

      {/* FLOATING AUDIO PLAYER */}
      <motion.div 
        initial={{ opacity: 0, y: -50 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 1 }}
        className="fixed top-20 right-6 z-40 hidden md:block"
      >
        <div className="bg-slate-900/90 backdrop-blur-xl border border-emerald-500/30 rounded-2xl p-4 shadow-2xl shadow-emerald-500/20">
          <div className="flex items-center gap-3">
            <motion.button
              onClick={handlePlayPause}
              className="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-500 to-cyan-500 flex items-center justify-center text-white relative overflow-hidden"
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.95 }}
              style={{
                boxShadow: isPlaying ? 
                  '0 0 20px rgba(34, 197, 94, 0.6), 0 0 40px rgba(34, 197, 94, 0.3)' : 
                  '0 0 10px rgba(34, 197, 94, 0.3)'
              }}
            >
              {isPlaying && (
                <motion.div
                  className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent"
                  animate={{ x: ['-100%', '100%'] }}
                  transition={{ duration: 2, repeat: Infinity, ease: 'linear' }}
                />
              )}
              <span className="relative z-10 text-sm">
                {isPlaying ? '⏸️' : '▶️'}
              </span>
            </motion.button>
            <div>
              <div className="text-sm font-medium text-white">{audioTracks[currentTrack].title}</div>
              <div className="text-xs text-emerald-400">{audioTracks[currentTrack].duration}</div>
            </div>
          </div>
        </div>
      </motion.div>

      {/* HERO */}
      <header className="pt-28 pb-20">
        <div className="max-w-6xl mx-auto px-6 grid grid-cols-12 gap-6 items-center">
          <motion.div className="col-span-7" style={{ y: y1 }}>
            <motion.h1 
              initial={{ opacity: 0, y: -18 }} 
              animate={{ opacity: 1, y: 0 }} 
              transition={{ delay: 0.05 }} 
              className="text-5xl md:text-6xl leading-tight font-aoboshi tracking-tight bg-gradient-to-r from-emerald-400 via-cyan-400 to-blue-400 bg-clip-text text-transparent"
            >
              {BOOK.title}
            </motion.h1>
            <motion.p 
              initial={{ opacity: 0 }} 
              animate={{ opacity: 1 }} 
              transition={{ delay: 0.2 }} 
              className="mt-4 text-lg text-gray-300 max-w-xl"
            >
              {BOOK.subtitle}
            </motion.p>
            <div className="mt-8 flex flex-wrap gap-3">
              <button 
                onClick={() => scrollToId('buy')} 
                className="inline-flex items-center gap-2 px-5 py-3 rounded-lg bg-gradient-to-r from-emerald-600 to-cyan-600 text-white font-semibold shadow-lg shadow-emerald-500/25 hover:from-emerald-700 hover:to-cyan-700 hover:translate-y-[-2px] transition-all duration-300"
              >
                Buy the Book <ArrowRight size={16} />
              </button>
              <button 
                onClick={() => setShowExcerpt(true)} 
                className="px-4 py-3 rounded-lg border border-emerald-500/30 text-emerald-400 hover:bg-emerald-500/10 hover:border-emerald-400 transition-all"
              >
                Read an Excerpt
              </button>
              <button 
                onClick={() => scrollToId('signup')} 
                className="px-4 py-3 rounded-lg border border-cyan-500/30 text-cyan-400 hover:bg-cyan-500/10 hover:border-cyan-400 transition-all inline-flex items-center gap-2"
              >
                <Mail size={14}/> Join the List
              </button>
            </div>
            <motion.div className="mt-6 text-xs text-gray-400">
              <span className="inline-block mr-2">⭐️⭐️⭐️⭐️⭐️ Early reviews</span>
              <span>"A river that remembers—beautiful and fierce." — Advance Reader</span>
            </motion.div>
          </motion.div>
          <motion.div className="col-span-5 flex justify-center" style={{ y: y2 }}>
            <div className="w-60 md:w-72 lg:w-80 rounded-xl overflow-hidden shadow-2xl bg-gradient-to-br from-slate-800 to-slate-900 border border-emerald-500/20">
              {/* Replace with actual cover image */}
              {BOOK.cover ? (
                <img src={BOOK.cover} alt="Book cover" className="aspect-[2/3] object-cover w-full" />
              ) : (
                <div className="aspect-[2/3] bg-gradient-to-br from-emerald-600/20 to-cyan-600/20 flex items-end p-6 relative">
                  <div className="absolute inset-0 bg-gradient-to-br from-emerald-500/10 to-cyan-500/10"></div>
                  <div className="relative z-10">
                    <div className="text-sm text-emerald-300 font-semibold">Cover mockup</div>
                    <div className="text-xs text-gray-400 mt-1">Drop in your cover image</div>
                  </div>
                </div>
              )}
            </div>
          </motion.div>
        </div>
        {/* subtle animated river background (SVG) */}
        <div className="pointer-events-none absolute inset-x-0 bottom-0 -z-10">
          <motion.svg viewBox="0 0 1440 200" preserveAspectRatio="none" className="w-full h-40" style={{ y: useTransform(scrollY, [0, 400], [0, -30]) }}>
            <defs>
              <linearGradient id="g1" x1="0" x2="1">
                <stop offset="0%" stopColor="#60a5fa" stopOpacity="0.12" />
                <stop offset="100%" stopColor="#34d399" stopOpacity="0.08" />
              </linearGradient>
            </defs>
            <path d="M0,160 C200,120 400,200 720,150 C1040,100 1200,180 1440,140 L1440,200 L0,200 Z" fill="url(#g1)" />
          </motion.svg>
        </div>
      </header>

      {/* ABOUT / FEATURES */}
      <section id="about" className="py-20">
        <div className="max-w-6xl mx-auto px-6">
          <motion.div initial="hidden" whileInView="show" viewport={{ once: true }} variants={{ show: { transition: { staggerChildren: 0.14 }}}}>
            <motion.h2 variants={reveal} className="text-3xl font-aoboshi text-white">About the story</motion.h2>
            <motion.p variants={reveal} className="mt-4 text-gray-300 max-w-3xl">
              Set in a world where rivers hold memory and power flows through bloodlines, <em className="text-emerald-400">The Current's Edge</em> follows Amara as she navigates the intersection of tradition and survival, discovering that some inheritances demand everything.
            </motion.p>
            <div className="mt-8 grid grid-cols-1 md:grid-cols-3 gap-6">
              {[
                { title: 'Inheritance', desc: 'Amara inherits more than land—she receives ancestral knowledge and the burden of choice.', color: 'emerald' },
                { title: 'Displacement', desc: 'When home becomes contested ground, every decision carries the risk of losing what matters most.', color: 'cyan' },
                { title: 'Language', desc: 'The river speaks in frequencies older than words, teaching those who learn to listen.', color: 'blue' },
              ].map((c, i) => (
                <motion.div 
                  key={c.title} 
                  variants={reveal} 
                  className={`bg-slate-800/50 border border-${c.color}-500/20 rounded-xl p-6 shadow-lg hover:shadow-${c.color}-500/10 transition-all`}
                  whileHover={{ y: -5, scale: 1.02 }}
                >
                  <div className={`text-lg font-semibold text-${c.color}-400`}>{c.title}</div>
                  <div className="mt-2 text-gray-300">{c.desc}</div>
                </motion.div>
              ))}
            </div>
          </motion.div>
        </div>
      </section>

      {/* EXCERPT */}
      <section id="excerpt" className="py-20 bg-slate-800/30">
        <div className="max-w-4xl mx-auto px-6">
          <motion.div initial="hidden" whileInView="show" viewport={{ once: true }} className="space-y-4">
            <motion.h3 variants={reveal} className="text-2xl font-aoboshi text-white">An Excerpt</motion.h3>
            <motion.div variants={reveal} className="prose max-w-none text-gray-300 whitespace-pre-line">{BOOK.excerpt}</motion.div>
            <div className="mt-4">
              <button onClick={() => setShowExcerpt(true)} className="px-4 py-2 rounded border border-emerald-500/30 text-emerald-400 hover:bg-emerald-500/10 hover:border-emerald-400 transition-all">Read more</button>
            </div>
          </motion.div>
        </div>
      </section>

      {/* REVIEWS / PULLQUOTES */}
      <section className="py-20">
        <div className="max-w-6xl mx-auto px-6">
          <motion.h4 initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} className="text-xl font-aoboshi text-white">Early Praise</motion.h4>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} className="mt-6 grid md:grid-cols-3 gap-6">
            {[
              "A mesmerizing blend of magical realism and environmental urgency. The Current's Edge flows with the power of tradition and the necessity of change.",
              "Amara's journey through inheritance and identity resonates with profound truth. This book will stay with you like the sound of running water.",
              "A powerful meditation on land, legacy, and the languages we inherit. Essential reading for our time.",
            ].map((q, i) => (
              <div key={i} className="bg-slate-800/50 border border-emerald-500/20 p-6 rounded-xl shadow-lg hover:shadow-emerald-500/10 transition-all">
                <div className="italic text-gray-300">"{q}"</div>
                <div className="mt-4 text-xs text-emerald-400">— Advance reader</div>
              </div>
            ))}
          </motion.div>
        </div>
      </section>

      {/* BUY / SIGNUP */}
      <section id="buy" className="py-20 bg-gradient-to-b from-slate-800/50 to-slate-900/50">
        <div className="max-w-4xl mx-auto px-6 grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
          <div>
            <motion.h2 initial={{ opacity: 0, x: -20 }} whileInView={{ opacity: 1, x: 0 }} className="text-3xl font-aoboshi text-white">Get a copy</motion.h2>
            <motion.p initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} className="mt-3 text-gray-300">
              Available in paperback, ebook, and audiobook. Preorder opens soon — sign up to get updates and limited edition extras.
            </motion.p>
            <div className="mt-6 flex gap-3">
              <a href={BOOK.buyLink} className="px-5 py-3 rounded-lg bg-gradient-to-r from-emerald-600 to-cyan-600 text-white font-semibold inline-flex items-center gap-2 hover:from-emerald-700 hover:to-cyan-700 transition-all shadow-lg shadow-emerald-500/25">Buy now <ShoppingCart size={14} /></a>
              <button onClick={() => scrollToId('signup')} className="px-5 py-3 rounded-lg border border-emerald-500/30 text-emerald-400 hover:bg-emerald-500/10 hover:border-emerald-400 transition-all">Join the list</button>
            </div>
          </div>
          <div>
            <motion.form onSubmit={handleMailSubmit} initial={{ opacity: 0, x: 20 }} whileInView={{ opacity: 1, x: 0 }} className="bg-slate-800/50 border border-emerald-500/20 p-6 rounded-xl shadow-lg">
              <div className="text-sm font-medium text-white">Join the mailing list</div>
              <div className="mt-3 flex gap-2">
                <input value={mail} onChange={e => setMail(e.target.value)} placeholder="you@domain.com" className="flex-1 border border-emerald-500/30 rounded px-3 py-2 bg-slate-700 text-white placeholder-gray-400 focus:border-emerald-400 focus:outline-none" />
                <button type="submit" className="px-3 py-2 rounded bg-gradient-to-r from-emerald-600 to-cyan-600 text-white hover:from-emerald-700 hover:to-cyan-700 transition-all">Subscribe</button>
              </div>
              {saved && <div className="mt-3 text-sm text-emerald-400">Thanks — you're on the list.</div>}
            </motion.form>
          </div>
        </div>
      </section>

      {/* AUTHOR */}
      <section className="py-20" id="signup">
        <div className="max-w-6xl mx-auto px-6 grid md:grid-cols-3 gap-6 items-center">
          <div className="col-span-1">
            {BOOK.author.photo ? (
              <img src={BOOK.author.photo} alt={BOOK.author.name} className="w-40 h-40 rounded-full object-cover border-2 border-emerald-500/30" />
            ) : (
              <div className="w-40 h-40 rounded-full bg-gradient-to-br from-emerald-600/20 to-cyan-600/20 border-2 border-emerald-500/30 flex items-center justify-center text-4xl text-emerald-400">📚</div>
            )}
          </div>
          <div className="col-span-2">
            <h5 className="text-xl font-aoboshi text-white">{BOOK.author.name}</h5>
            <p className="mt-2 text-gray-300">{BOOK.author.bio}</p>
            <div className="mt-4 flex gap-3">
              <a className="px-4 py-2 rounded border border-emerald-500/30 text-emerald-400 hover:bg-emerald-500/10 hover:border-emerald-400 transition-all cursor-pointer">Contact</a>
              <a className="px-4 py-2 rounded border border-cyan-500/30 text-cyan-400 hover:bg-cyan-500/10 hover:border-cyan-400 transition-all cursor-pointer">Events</a>
            </div>
          </div>
        </div>
      </section>

      {/* FOOTER */}
      <footer className="py-8 bg-slate-900 border-t border-emerald-500/20">
        <div className="max-w-6xl mx-auto px-6 text-sm text-gray-400 flex justify-between items-center">
          <div>© {new Date().getFullYear()} {BOOK.author.name}</div>
          <div className="flex gap-4">
            <a className="hover:text-emerald-400 transition-colors cursor-pointer">Privacy</a>
            <a className="hover:text-emerald-400 transition-colors cursor-pointer">Terms</a>
          </div>
        </div>
      </footer>

      {/* Excerpt modal (client-side) */}
      {showExcerpt && (
        <div className="fixed inset-0 z-60 flex items-center justify-center bg-black/60 p-6">
          <motion.div initial={{ scale: 0.9, opacity: 0 }} animate={{ scale: 1, opacity: 1 }} className="max-w-3xl w-full bg-slate-800 border border-emerald-500/20 rounded-xl p-6 shadow-2xl">
            <div className="flex items-start justify-between">
              <h4 className="text-lg font-aoboshi text-white">Excerpt — {BOOK.title}</h4>
              <button onClick={() => setShowExcerpt(false)} className="text-gray-400 hover:text-white transition-colors">Close</button>
            </div>
            <div className="mt-4 prose whitespace-pre-line text-gray-300">
              <p>{BOOK.excerpt}</p>
              <p>— continued —</p>
              <p className="mt-4 text-gray-500 text-sm">(This is a placeholder excerpt. Replace with your full excerpt or integrate your CMS/MDX.)</p>
            </div>
            <div className="mt-6 flex justify-end">
              <a href={BOOK.buyLink} className="px-4 py-2 rounded bg-gradient-to-r from-emerald-600 to-cyan-600 text-white hover:from-emerald-700 hover:to-cyan-700 transition-all">Buy the Book</a>
            </div>
          </motion.div>
        </div>
      )}
    </div>
  );
}
