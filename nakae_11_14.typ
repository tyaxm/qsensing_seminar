#import "@preview/touying:0.8.0": *
#import themes.university: *

#import "@preview/physica:0.9.8" : *

#set text(font: "Yu Mincho")

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
 config-info(
    title: [11/14発表],
    author: [中江悠太],
    date: [2026-11-14],
  ),
)



#title-slide()

= 6章

== ACシグナルのセンシング
これまでの議論は時間依存性のない信号が対象だった。
これからは時間依存する信号の検出を考える。

- 振動する信号の振幅、周波数、位相
- 波形全部

6章では基本波と高調波からなる信号を扱う

== ラムゼー測定再考
測定
$
  ket(0)
  &->^(pi/2)
  1/sqrt(2) (ket(0) + ket(1)) \
  &->^t 
  1/sqrt(2) (ket(0) + e^(-i omega_0 t) ket(1))\ 
  &->^(pi/2)
  1/2 (1 + e^(-i omega_0 t)) ket(0) + 1/2 (1 - e^(-i omega_0 t)) ket(1)

$

$ket(1)$が測定される確率
$
  p = 1/2 - 1/2 cos(omega_0 t)
$

#figure(caption: [静的信号の測定])[
  #image("assets/image-1.png",width: 100%)
]

== ラムゼー測定再考
遷移エネルギーが時間依存する場合
$
  phi = integral^t_0 dd(t') gamma V(t')
$

信号が静的とみなせる場合
$
  phi = gamma V t
$

信号が素早く振動する場合
$
  phi tilde.eq 0
$
...なんの情報も得られない。

== ラムゼー測定再考
途中で信号をひっくり返せば積分が0にならない。
#figure(caption: [周期がちょうどtの信号の測定])[
  #image("assets/image-2.png",width: 100%)
]

== multipulse sensing sequences
より一般的に
$
  phi = integral_0^t gamma V(t') y(t') dd(t)
$


$V(t) = V_"pk" cos(2 pi f t + alpha)$
に対して、
$
  phi = gamma V_"pk" t times W(f,alpha)
$
各周波数、位相に対して重み関数$W$が求まる。

実は、積分は$y$をIRとした線形フィルターであり、重み関数は伝達関数といえる。

== CP and PDD sequences
CP sequence : $t_j = (2j - 1)/2 tau$
$
  W(f,alpha) = sinc(pi f n tau)[1 - sec(pi f t)]cos(alpha + pi f n tau)
$

PDD sequence : $t_j = j tau$
$
  W(f,alpha) = sinc(pi f n tau)tan(pi f tau) sin(alpha + pi f tau)
$

- sinc + 周期$1slash tau$で発散する関数 + 位相の影響 の形

== CP and PDD sequences
最終的に、確率
$
  p = 1/2 - 1/2 cos(W(f,alpha) gamma V_"pk" t)
$
を測定する。

- 周波数がわかってれば$V_"pk"$がわかりそう

- 高調波を含む場合どうする？

== Lock-in detection
信号$V$とモジュレーション$y$の位相差$alpha$の値によって、$phi$が最大化したり0になったりする。

$->$ ロックイン検出(?) 

#let avg(x) = $lr(chevron.l #x chevron.r)$






== phaseがrandomな場合
推移確率は、
$
  p(t) = 1/2 - 1/2 J_0(sqrt(2) dash(W)(f_"ac") gamma V_"rms" t) 
$
- $J_0$は第一種ベッセル関数
- $V_"rms" = V_"pk"slash sqrt(2)$
- $phi$が小さいときはこれは、$avg(phi^2)$に比例する
- $dash(W)^2 (f_"ac")$は$dash(W)^2 (f_"ac",alpha)$を位相で平均したやつ

#figure(caption: [重み関数の形])[
  #image("assets/image-3.png")
]

== phaseもamplitudeもrandomな場合
さらに、amplitudeの分布で平均を取ることになる。

遷移確率は
$
  p(t) = 1/2 - 1/2 exp(- 1/2 ((dash(W) gamma V_"rms" t)/k)^2) I_0(1/2 ((dash(W) gamma V_"rms" t)/k)^2)
$
- $I_0$は、第一種変形ベッセル関数
- 分布は平均0,標準偏差$V_"rms"$のガウス分布を仮定

== 波形の再構成
ウォルシュ基底$w_n$を使う。
$
  phi(t) = gamma integral_0^t V(t') w_n (t'slash t) dd(t') = gamma V_n t 
$
を測定。Nはウォルシュ基底の分割数として、
$
  V_N (t') = sum_n V_n w_n (t' slash t)
$
これは$N->infinity$で元の信号と一致。

ウォルシュ・フーリエ変換というらしい。

== 周波数推定
- 普通に周波数掃引を考えると、分解能は$Delta f = 1/T_2$が限界

=== Correlation sequences
#figure(caption: none)[
#image("assets/image-4.png")
]

$
  p(t_1) =  1/2 - 1/2 sin(Phi cos(alpha)) sin(Phi cos(alpha + 2pi f_"ac" t_1))
$

- 自由発展させている間は、$T_1$で緩和するので、$Delta f = 1 / T_1$に高められる


== 周波数推定
=== Continuous sampling
#figure(caption:none)[
  #image("assets/image-5.png")
]
$
  p(t) = 1/2 - 1/2 sin(Phi cos(alpha + 2pi f_"ac" t))
$
一回一回の測定結果はランダムのように見えるが、フーリエ変換すると、信号の周波数のところにピークができるはず。

- 実験をたくさんすればその分だけ解像度があがる

= 7章
== ノイズ分光
- 確率的な信号の周波数スペクトラムを再構成する
- センシングプロトコルの選択に役立てる\ （動的デカップリングや量子誤り訂正のプロトコル選択）

== ノイズ過程
- ガウス過程：信号がガウス分布に従う

ノイズのスペクトラムは自己相関関数$G_V (t) = chevron.l V(t+t_0) V(t) chevron.r$を用いて表せる。
$
  S_V (omega) = integral_infinity^infinity dd(t) e^(- i omega t) G_V (t)
$

- もし相関が失われるのが速いなら、なだらかなスペクトル
- ノイズ分光の目標：$S_V$を測定から導きたい

== デコヒーレンス
ノイズ信号のもとでラムゼー測定を考える
$
  p(t) = 1/2(1 - e^(-phi^2 slash 2))) = 1/2(1 - e^(- chi(t)))
$
- ノイズの種類によって、$chi(t)$の形がわかる \ 例：ホワイトノイズ$chi(t) = Gamma t$
- $chi$は実験で測定できる

== Filter function $Y(omega)$
知りたいのはノイズのスペクトラム、もしくは自己相関関数といえる
$
  chi(t) 
  &= 1/2 integral_0^t integral_0^t dd(t') dd(t'') y(t') y(t'') gamma^2 G_v (t'-t'')\
  &= 2/pi integral_0^infinity dd(omega) gamma^2 S_V (omega) abs(Y(omega))^2
$
- $Y(omega)$は$y(t)$の伝達関数

== ラムゼー測定の場合
$
  abs(Y(omega))^2 = (sin^2(omega t slash 2))/omega^2
$
$
  chi(t) = 2/pi integral_0^infinity gamma^2 S_V (omega) (sin^2(omega t slash 2))/omega^2 tilde.eq 1/2 gamma^2 S_V (0) t
$
- 最後の等式は$S_V$が0付近で平坦だと仮定

== 動的デカップリング
周期的な変調関数を考えると、基本波とその高調波のところに伝達関数のピークが並ぶ
$
  Y_(n,tau) (omega)= Y_(1,tau) (omega) sum_k e^(i tau k) = Y_(1,tau)e^(-i (n-1) omega tau slash 2) sin(n omega tau slash 2)/sin(omega tau slash 2)
$
- nが大きいと、$f = 1/tau$のところに鋭いピーク $<-$ delta関数で近似

== CP,PPDシーケンスの場合
$
  abs(Y)^2 tilde.eq sum_k (2pi)/(k pi)^2 t delta(omega - omega_k)
$
$
  chi(t) = (4t)/pi^2 sum_k (gamma^2 S_V (omega_k))/k^2
$
- $tau$を掃引して測定すれば$S_V$を得ることができそう。

== Relaxometry
$S_V$と一次の緩和$chi(t) = Gamma t$を結び付けたい。

二準位系で$omega$の成分による遷移を一時摂動で
$
  abs(c_1 (t))^2 &= abs(braket(phi_1,H_V (omega),phi_0))^2 ((sin[(omega_"01" -omega)t slash 2])/((omega_"01" -omega) slash 2))^2 \
  &=abs(braket(phi_1,H_V (omega),phi_0))^2 2pi t delta(omega_(0 1) - omega)
$

これを周波数について積分すると
$
  Gamma = 2 abs(braket(phi_1,H_V (omega_(0 1)),phi_0))^2 = 2 gamma^2 S_V_(01) (omega_01) times abs(braket(phi_1,sigma_V slash 2 ,phi_0))^2
$

== Relaxometry
ラムゼー位相の観点からは
$
  phi_"rms"^2 =2 Gamma t = 4 gamma^2 S_V_(01) (omega_01)abs(braket(phi_1,sigma_V slash 2 ,phi_0))^2 (omega_(01)) t
$
- The rms phase thus corresponds to the noise integrated
over an equivalent noise bandwidth of 1/(2πt). ????
