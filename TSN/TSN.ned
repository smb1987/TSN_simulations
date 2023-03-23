import inet.networks.base.TsnNetworkBase;
import inet.node.contract.IEthernetNetworkNode;
import inet.node.ethernet.EthernetLink;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

import inet.queueing.base.PacketGateBase;
import inet.queueing.contract.IPacketGate;

network TSN_Network extends TsnNetworkBase
{
    parameters:
        *.eth[*].bitrate = default(100Mbps);
        @display("bgb=1882,894");
    submodules:
        vlanConfigurator: Ipv4NetworkConfigurator {
            @display("p=99,810;is=s");
        }


        TSN_sensorA1: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=399,136");
        }
        TSN_sensorA2: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=324,242");
        }
        TSN_bridgeA: <default("TsnSwitch")> like IEthernetNetworkNode {
            @display("p=578,200");
        }


        TSN_sensorB1: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=399,612");
        }
        TSN_sensorB2: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=324,487");
        }
        TSN_bridgeB: <default("TsnSwitch")> like IEthernetNetworkNode {
            @display("p=578,533");
        }


        TSN_sensorC1: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=1691,136");
        }
        TSN_sensorC2: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=1745,242");
        }
        TSN_bridgeC: <default("TsnSwitch")> like IEthernetNetworkNode {
            @display("p=1519,200");
        }


        TSN_sensorD1: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=1745,487");
        }
        TSN_sensorD2: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=1691,612");
        }
        TSN_bridgeD: <default("TsnSwitch")> like IEthernetNetworkNode {
            @display("p=1519,533");
        }


        TSN_serverA: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=824,487");
        }
        TSN_sensorY: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=968,487");
        }
        TSN_sensorZ: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=1110,487");
        }
        TSN_serverB: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=1238,487");
        }
        TSN_bridgeAB: <default("TsnSwitch")> like IEthernetNetworkNode {
            @display("p=903,350");
        }
        TSN_bridgeCD: <default("TsnSwitch")> like IEthernetNetworkNode {
            @display("p=1175,350");
        }
    connections:
        TSN_sensorA1.ethg++ <--> EthernetLink <--> TSN_bridgeA.ethg++;
        TSN_sensorA2.ethg++ <--> EthernetLink <--> TSN_bridgeA.ethg++;
        TSN_bridgeA.ethg++ <--> EthernetLink <--> TSN_bridgeAB.ethg++;

        TSN_sensorB1.ethg++ <--> EthernetLink <--> TSN_bridgeB.ethg++;
        TSN_sensorB2.ethg++ <--> EthernetLink <--> TSN_bridgeB.ethg++;
        TSN_bridgeB.ethg++ <--> EthernetLink <--> TSN_bridgeAB.ethg++;

        TSN_sensorC1.ethg++ <--> EthernetLink <--> TSN_bridgeC.ethg++;
        TSN_sensorC2.ethg++ <--> EthernetLink <--> TSN_bridgeC.ethg++;
        TSN_bridgeC.ethg++ <--> EthernetLink <--> TSN_bridgeCD.ethg++;

        TSN_sensorD1.ethg++ <--> EthernetLink <--> TSN_bridgeD.ethg++;
        TSN_sensorD2.ethg++ <--> EthernetLink <--> TSN_bridgeD.ethg++;
        TSN_bridgeD.ethg++ <--> EthernetLink <--> TSN_bridgeCD.ethg++;

        TSN_sensorY.ethg++ <--> EthernetLink <--> TSN_bridgeAB.ethg++;
        TSN_serverA.ethg++ <--> EthernetLink <--> TSN_bridgeAB.ethg++;

        TSN_sensorZ.ethg++ <--> EthernetLink <--> TSN_bridgeCD.ethg++;
        TSN_serverB.ethg++ <--> EthernetLink <--> TSN_bridgeCD.ethg++;

        TSN_bridgeAB.ethg++ <--> EthernetLink <--> TSN_bridgeCD.ethg++;        
}



simple PacketGate extends PacketGateBase like IPacketGate
{
    parameters:
        string clockModule = default("");
        bool initiallyOpen = default(false);
        double openTime @unit(s);
        double closeTime @unit(s);
        @class(PacketGate);
}