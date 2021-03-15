#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "OpenVPNAdapter.h"
#import "OpenVPNAdapterEvent.h"
#import "OpenVPNAdapterPacketFlow.h"
#import "OpenVPNCertificate.h"
#import "OpenVPNCompressionMode.h"
#import "OpenVPNConfiguration.h"
#import "OpenVPNConfigurationEvaluation.h"
#import "OpenVPNConnectionInfo.h"
#import "OpenVPNCredentials.h"
#import "OpenVPNError.h"
#import "OpenVPNInterfaceStats.h"
#import "OpenVPNIPv6Preference.h"
#import "OpenVPNKeyType.h"
#import "OpenVPNMinTLSVersion.h"
#import "OpenVPNPrivateKey.h"
#import "OpenVPNReachability.h"
#import "OpenVPNReachabilityStatus.h"
#import "OpenVPNServerEntry.h"
#import "OpenVPNSessionToken.h"
#import "OpenVPNTLSCertProfile.h"
#import "OpenVPNTransportProtocol.h"
#import "OpenVPNTransportStats.h"

FOUNDATION_EXPORT double OpenVPNAdapterVersionNumber;
FOUNDATION_EXPORT const unsigned char OpenVPNAdapterVersionString[];

