
#include "../SystemUtilitiesFactory.h"
#include "WinDiskCollector.h"
#include "agent/IProbe.h"
#include "WinGeneralAnalyzer.h"


std::unique_ptr<IDiskCollector> SystemUtilitiesFactory::diskCollector()
{
    return std::make_unique<WinDiskCollector>();
}

std::unique_ptr<IProbe> SystemUtilitiesFactory::generalAnalyzer()
{
    return std::make_unique<WinGeneralAnalyzer>();
}