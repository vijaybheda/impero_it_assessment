import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:impero_it_assessment/navigation/getx_navigation.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(noCoonectionIllistration, fit: BoxFit.scaleDown),
                ),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Opps!....",
                description:
                    "Something wrong with your connection, Please try again after a moment.",
                press: () {
                  GetxNavigation().navigateToNextAndRemovePreviousAll('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(description, textAlign: TextAlign.center),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: Text(btnText ?? "Retry".toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

const noCoonectionIllistration =
    '''<svg width="1080" height="1080" viewBox="0 0 1080 1080" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M495.37 347.17C529.49 305.3 601.8 305.22 636.11 346.94" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M572.22 752.17C632.85 752.17 682 707.533 682 652.47C682 597.407 632.85 552.77 572.22 552.77C511.59 552.77 462.44 597.407 462.44 652.47C462.44 707.533 511.59 752.17 572.22 752.17Z" fill="#D3D3D3"/>
<path d="M661.48 426.87C648.61 485.3 705.2 572.53 710.53 651.73C711.31 783.67 431.53 787.67 431.53 651.73C431.53 579.49 479.87 496.31 469.24 430.06" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M431.53 662.34C390.53 644.86 369.53 619.67 350.42 574.67C337.97 542.17 291.72 578.17 266.72 617C260.47 626.42 246.47 618.17 262.05 592.33C292.97 545.57 343.37 523.16 362.05 551.41C373.97 569.16 394.22 634.41 431.79 642.31" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M506.1 741.48L463.77 762.1C461.272 763.308 458.397 763.479 455.773 762.574C453.15 761.668 450.992 759.762 449.77 757.27V757.27C448.561 754.772 448.391 751.897 449.296 749.273C450.201 746.65 452.108 744.492 454.6 743.27L481.46 730.19" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M670.32 726.24L696.44 735.24C699.059 736.153 701.211 738.065 702.425 740.559C703.639 743.053 703.817 745.925 702.92 748.55V748.55C702.001 751.164 700.086 753.308 697.593 754.516C695.1 755.724 692.231 755.898 689.61 755L645 739.65" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M574.43 435.75L566.38 443.8C566.099 444.081 565.718 444.239 565.32 444.239C564.923 444.239 564.541 444.081 564.26 443.8L556.21 435.75C555.929 435.469 555.771 435.088 555.771 434.69C555.771 434.293 555.929 433.911 556.21 433.63H574.43C574.711 433.911 574.869 434.293 574.869 434.69C574.869 435.088 574.711 435.469 574.43 435.75Z" fill="#0E0E0E"/>
<path d="M546.45 459.17H584.18" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M563.19 459.17H557.7C556.85 459.17 556.16 459.859 556.16 460.71V467.8C556.16 468.651 556.85 469.34 557.7 469.34H563.19C564.041 469.34 564.73 468.651 564.73 467.8V460.71C564.73 459.859 564.041 459.17 563.19 459.17Z" fill="#0E0E0E"/>
<path d="M573.78 459.17H568.29C567.439 459.17 566.75 459.859 566.75 460.71V467.8C566.75 468.651 567.439 469.34 568.29 469.34H573.78C574.631 469.34 575.32 468.651 575.32 467.8V460.71C575.32 459.859 574.631 459.17 573.78 459.17Z" fill="#0E0E0E"/>
<path d="M503.73 336.79C503.662 322.635 499.535 308.796 491.84 296.915C484.144 285.034 473.202 275.61 460.311 269.76C447.421 263.91 433.124 261.88 419.114 263.911C405.105 265.942 391.973 271.949 381.274 281.218C370.576 290.487 362.76 302.631 358.755 316.208C354.75 329.785 354.723 344.226 358.677 357.818C362.631 371.41 370.401 383.582 381.065 392.892C391.729 402.201 404.839 408.257 418.84 410.34C437.64 413.14 455.11 407.6 469.84 397.88" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M626 336.79C626.068 322.635 630.195 308.796 637.891 296.915C645.586 285.034 656.528 275.61 669.419 269.76C682.309 263.91 696.607 261.88 710.616 263.911C724.625 265.942 737.757 271.949 748.456 281.218C759.155 290.487 766.97 302.631 770.975 316.208C774.98 329.785 775.007 344.226 771.053 357.818C767.099 371.41 759.329 383.582 748.665 392.892C738.002 402.201 724.891 408.257 710.89 410.34C692.09 413.14 674.62 407.6 659.89 397.88" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M695.05 398.72C721.394 398.72 742.75 377.364 742.75 351.02C742.75 324.676 721.394 303.32 695.05 303.32C668.706 303.32 647.35 324.676 647.35 351.02C647.35 377.364 668.706 398.72 695.05 398.72Z" fill="#ABABAB"/>
<path d="M433.8 398.72C460.144 398.72 481.5 377.364 481.5 351.02C481.5 324.676 460.144 303.32 433.8 303.32C407.456 303.32 386.1 324.676 386.1 351.02C386.1 377.364 407.456 398.72 433.8 398.72Z" fill="#ABABAB"/>
<path d="M495.37 347.17C476.71 365.36 466.37 391.94 469.25 430.07" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M661.48 426.87C661.82 394.137 653.36 367.493 636.1 346.94" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M614.32 437.9C658.781 431.155 703.806 428.89 748.72 431.14" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M614.79 447.61C649.959 450.031 684.899 455.069 719.32 462.68" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M615.66 458.63C642.4 462.22 668.86 469.3 695.06 478.42" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M521.1 437.9C476.639 431.155 431.614 428.89 386.7 431.14" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M520.63 447.61C485.461 450.035 450.521 455.075 416.1 462.69" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M519.77 458.63C493.03 462.22 466.57 469.3 440.37 478.42" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M550.52 492.56C536.16 497.12 482.97 521.77 464.19 535.3C416.55 571.83 405.05 677.83 339.19 747.39C254.54 845.34 532.54 780.84 550 846.48C537 897.84 730 793.34 834.59 817.84C899.04 845.08 888.04 886.84 809.09 884.2C651.84 889.78 477.54 901.84 486.09 872.5C516.54 836.84 681 771.34 617.83 758.8C593.54 752.86 534.04 768.34 542.26 751.37" stroke="#0E0E0E" stroke-width="9" stroke-miterlimit="10"/>
<path d="M871.18 610.66C776.72 615.17 750.72 608.54 646.37 522.5C632.72 511.17 605.09 494.83 588.16 493.83" stroke="#0E0E0E" stroke-width="9" stroke-miterlimit="10"/>
<path d="M529.58 502.88C542.13 493.6 553.37 498.31 564.17 491.12" stroke="#0E0E0E" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M536.78 497.46C554.02 495.81 560.78 485.64 565.22 487.46" stroke="#0E0E0E" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M537.19 497.46C547.29 487.69 554.96 490.07 561.9 484.79" stroke="#0E0E0E" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M610.36 503.77C598.11 493.83 577.8 497.85 570.93 492.01" stroke="#0E0E0E" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M601.28 497.21C582.86 495.21 575.42 489.15 568.86 488.35" stroke="#0E0E0E" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M601.07 497.85C588.54 488.35 579.61 491.02 572.47 486.21" stroke="#0E0E0E" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M534.52 515L503.06 559.1C502.288 560.176 501.304 561.082 500.168 561.761C499.032 562.441 497.768 562.879 496.455 563.05C495.142 563.221 493.808 563.12 492.536 562.753C491.264 562.387 490.081 561.763 489.06 560.92L485.26 557.76C484.253 556.918 483.428 555.88 482.835 554.708C482.243 553.537 481.895 552.257 481.814 550.947C481.732 549.637 481.919 548.324 482.362 547.088C482.805 545.853 483.495 544.72 484.39 543.76L521.49 504.16C522.206 503.3 523.084 502.589 524.074 502.068C525.064 501.547 526.148 501.226 527.262 501.124C528.376 501.022 529.5 501.141 530.569 501.473C531.637 501.805 532.63 502.344 533.49 503.06V503.06C535.199 504.514 536.266 506.583 536.459 508.818C536.652 511.054 535.955 513.275 534.52 515Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M604.61 515L636.06 559.11C636.832 560.186 637.816 561.092 638.952 561.771C640.088 562.451 641.352 562.889 642.665 563.06C643.978 563.231 645.312 563.13 646.584 562.763C647.856 562.397 649.039 561.773 650.06 560.93L653.86 557.77C654.867 556.928 655.692 555.89 656.285 554.718C656.878 553.547 657.225 552.267 657.307 550.957C657.388 549.647 657.202 548.334 656.759 547.098C656.316 545.862 655.625 544.73 654.73 543.77L617.63 504.17C616.914 503.31 616.036 502.599 615.046 502.078C614.056 501.557 612.972 501.237 611.858 501.134C610.744 501.032 609.62 501.151 608.552 501.483C607.483 501.815 606.49 502.354 605.63 503.07V503.07C603.925 504.525 602.862 506.593 602.671 508.826C602.48 511.059 603.177 513.277 604.61 515V515Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M876.336 597.391L875.096 597.403C872.882 597.423 871.103 599.234 871.123 601.449L871.286 619.428C871.306 621.643 873.118 623.422 875.332 623.401L876.572 623.39C878.787 623.37 880.566 621.559 880.546 619.344L880.382 601.365C880.362 599.15 878.551 597.371 876.336 597.391Z" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10"/>
<path d="M912.486 591.993L888.737 592.209C884.082 592.251 880.342 596.059 880.384 600.715L880.538 617.714C880.581 622.37 884.389 626.11 889.045 626.067L912.794 625.852C917.449 625.81 921.189 622.001 921.147 617.346L920.992 600.346C920.95 595.691 917.142 591.951 912.486 591.993Z" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10"/>
<path d="M938.32 571.13C938.32 567.446 935.336 564.46 931.655 564.46C927.974 564.46 924.99 567.446 924.99 571.13V646.46C924.99 650.144 927.974 653.13 931.655 653.13C935.336 653.13 938.32 650.144 938.32 646.46V571.13Z" fill="#0E0E0E"/>
<path d="M928.04 604.67H924.66C922.661 604.67 921.04 606.291 921.04 608.29V608.8C921.04 610.799 922.661 612.42 924.66 612.42H928.04C930.039 612.42 931.66 610.799 931.66 608.8V608.29C931.66 606.291 930.039 604.67 928.04 604.67Z" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10"/>
<path d="M231.67 242.46L176.67 218.98" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M229.67 258.59L207.44 265.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M802.83 134.84L807.9 120.84" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M822.08 146.84L833.78 120.84" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M788.74 137.84L781.05 127.84" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M239.28 221.56L256.59 219.41C256.94 219.365 257.296 219.39 257.636 219.483C257.977 219.576 258.296 219.735 258.574 219.952C258.853 220.168 259.086 220.438 259.261 220.745C259.435 221.051 259.547 221.39 259.59 221.74L261.74 239.05C261.785 239.4 261.76 239.756 261.667 240.096C261.574 240.437 261.415 240.755 261.199 241.034C260.982 241.313 260.713 241.546 260.406 241.72C260.099 241.895 259.761 242.007 259.41 242.05L236.97 224.56C236.879 223.856 237.072 223.145 237.505 222.582C237.938 222.02 238.576 221.652 239.28 221.56Z" fill="#E2E2E2"/>
<path d="M246.75 267.26L244.44 255C244.349 254.5 244.459 253.985 244.745 253.566C245.031 253.147 245.471 252.857 245.97 252.76L258.28 250.44C258.779 250.349 259.295 250.459 259.714 250.745C260.133 251.032 260.423 251.472 260.52 251.97L249 268.79C248.499 268.884 247.981 268.776 247.559 268.489C247.138 268.202 246.847 267.76 246.75 267.26Z" fill="#E2E2E2"/>
<path d="M776.66 159.81L806.48 156.11C807.691 155.963 808.912 156.301 809.875 157.05C810.838 157.8 811.465 158.9 811.62 160.11L815.32 189.93C815.467 191.141 815.129 192.362 814.38 193.325C813.631 194.288 812.531 194.915 811.32 195.07L772.65 165C772.57 164.396 772.611 163.781 772.769 163.193C772.928 162.604 773.202 162.052 773.574 161.57C773.947 161.088 774.412 160.684 774.941 160.382C775.471 160.08 776.055 159.885 776.66 159.81Z" fill="#E2E2E2"/>
<path d="M716.58 173L714.26 160.69C714.169 160.19 714.279 159.675 714.565 159.256C714.852 158.837 715.292 158.547 715.79 158.45L728.1 156.13C728.6 156.039 729.115 156.149 729.534 156.435C729.954 156.721 730.243 157.162 730.34 157.66L718.82 174.53C718.321 174.621 717.805 174.511 717.386 174.225C716.967 173.938 716.677 173.498 716.58 173Z" fill="#E2E2E2"/>
<path d="M864.86 491.01L862.3 532.11L877.43 527.56L881.83 574.32L883.92 520.41L868.99 525.54L864.86 491.01Z" fill="#D3D3D3"/>
<path d="M827.23 572.12L849.43 581.41L849.82 572.18L876.48 578.72L847.12 567.23L847.09 576.46L827.23 572.12Z" fill="#D3D3D3"/>
<path d="M533.55 413.16C537.974 413.16 541.56 406.086 541.56 397.36C541.56 388.634 537.974 381.56 533.55 381.56C529.126 381.56 525.54 388.634 525.54 397.36C525.54 406.086 529.126 413.16 533.55 413.16Z" fill="#0E0E0E"/>
<path d="M531.94 393.2C533.249 393.2 534.31 392.336 534.31 391.27C534.31 390.204 533.249 389.34 531.94 389.34C530.631 389.34 529.57 390.204 529.57 391.27C529.57 392.336 530.631 393.2 531.94 393.2Z" fill="white"/>
<path d="M595.55 413.16C599.974 413.16 603.56 406.086 603.56 397.36C603.56 388.634 599.974 381.56 595.55 381.56C591.126 381.56 587.54 388.634 587.54 397.36C587.54 406.086 591.126 413.16 595.55 413.16Z" fill="#0E0E0E"/>
<path d="M594.46 393.2C595.769 393.2 596.83 392.336 596.83 391.27C596.83 390.204 595.769 389.34 594.46 389.34C593.151 389.34 592.09 390.204 592.09 391.27C592.09 392.336 593.151 393.2 594.46 393.2Z" fill="white"/>
<path d="M936.82 161.11V967.8" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M238.67 815.79L154.09 872.31L167.42 931.31L300.08 901.31L285.41 836.39C280.53 814.83 264 810.39 238.67 815.79Z" fill="#ABABAB"/>
<path d="M218.77 848.31L156.63 862.31L253.37 797.39C279.07 798.19 293.427 809.3 296.44 830.72L253.77 840.36" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M253.76 840.4L296.44 830.76L310.13 890.55L298.25 893.23" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M161.77 885.11L156.63 862.35L218.77 848.31" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M272.56 899.03L170.14 922.18L166.76 907.22" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M260.202 823.231C269.36 821.162 276.192 816.864 275.461 813.632C274.731 810.4 266.715 809.457 257.557 811.526C248.399 813.594 241.567 817.892 242.297 821.124C243.027 824.356 251.043 825.299 260.202 823.231Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M224.32 816.93C228.77 816.74 231.93 817.5 232.32 819.09C232.87 821.53 226.62 825.02 218.32 826.89C214.889 827.711 211.366 828.084 207.84 828" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M161.77 885.11C164.702 884.447 167.777 884.976 170.319 886.58C172.861 888.185 174.662 890.733 175.325 893.665C175.988 896.597 175.459 899.672 173.855 902.214C172.25 904.756 169.702 906.557 166.77 907.22" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M227.221 896.601C235.479 894.735 240.661 886.528 238.796 878.269C236.93 870.011 228.723 864.829 220.464 866.694C212.206 868.56 207.024 876.767 208.889 885.025C210.755 893.284 218.962 898.466 227.221 896.601Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M268.575 881.49C271.986 880.719 274.125 877.33 273.355 873.92C272.585 870.51 269.196 868.37 265.786 869.141C262.376 869.911 260.236 873.3 261.006 876.71C261.777 880.12 265.165 882.26 268.575 881.49Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M279.739 859.824C284.766 858.689 287.92 853.694 286.784 848.668C285.649 843.641 280.654 840.487 275.628 841.623C270.601 842.758 267.447 847.753 268.583 852.78C269.718 857.806 274.713 860.96 279.739 859.824Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M189.287 882.99C193.235 882.098 195.713 878.174 194.821 874.225C193.929 870.276 190.005 867.799 186.056 868.691C182.107 869.583 179.629 873.507 180.521 877.456C181.414 881.404 185.338 883.882 189.287 882.99Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M272.69 899C272.27 892.9 276.69 887.15 283.18 885.68C286.075 884.959 289.129 885.246 291.839 886.493C294.549 887.74 296.754 889.873 298.09 892.54" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M219.1 849.76C217.92 844.55 224.6 838.61 234.02 836.48C243.44 834.35 252.02 836.85 253.2 842.06C254.38 847.27 247.7 853.21 238.28 855.34C228.86 857.47 220.28 854.97 219.1 849.76Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M168.69 780.09L154.09 765.04" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M194 789.66L193 763.64" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M156.63 815.14L135 810.92" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''';
